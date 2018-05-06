integer channel_constant = 38609;
string unique_name = "A Unique Name";
list faces = ["ALL_SIDES", "1,2,3"];

list TypedList2List(list typed) {
    list untyped = [];
    integer length = llGetListLength(typed);
    integer i;
    integer type;

    for (i = 0; i < length; i++) {
        type = (integer)llList2String(typed, i++);
        if (i >= length) return untyped;

        if (type == TYPE_FLOAT) {
            untyped += (float)llList2String(typed, i);
        } else if (type == TYPE_INTEGER) {
            untyped += (integer)llList2String(typed, i);
        } else if (type == TYPE_KEY) {
            untyped += (key)llList2String(typed, i);
        } else if (type == TYPE_ROTATION) {
            untyped += (rotation)llList2String(typed, i);
        } else if (type == TYPE_STRING) {
            untyped += llList2String(typed, i);
        } else if (type == TYPE_VECTOR) {
            untyped += (vector)llList2String(typed, i);
        }
    }

    return untyped;
}

list PrimitiveParamsTexture(integer side, string texture) {
    if (side == ALL_SIDES) {
        list params;

        integer this_faces = llGetLinkNumberOfSides(LINK_THIS);
        integer this_face;
        for (this_face = 0; this_face < this_faces; this_face++) {
            params += PrimitiveParamsTexture(this_face, texture);
        }

        return params;
    }

    list old_params = llGetLinkPrimitiveParams(LINK_THIS, [PRIM_TEXTURE, side]);
    return [PRIM_TEXTURE, side, texture] + llList2List(old_params, 1, 3);
}

default {
    state_entry() {
        llListen(channel_constant, "", NULL_KEY, "");
    }

    listen(integer channel, string name, key id, string message)
    {
        list params;
        list split = llCSV2List(message);
        integer length = llGetListLength(split);
        integer faceLength = llGetListLength(faces);
        integer faceProcessed = 0;
        if (llList2String(split, 0) == unique_name) {
            length = length - 1;
            split = TypedList2List(llList2List(split, 1, length));
            length = llGetListLength(split);

            integer i;
            for (i = 0; i < length; i += 1) {
                string face_texture = llList2String(split, i);
                list fn = llParseString2List(face_texture, [":"], []);
                if (llGetListLength(fn) > 1 && llList2String(fn, 0) == "fn") {
                    integer argLength = length - i;
                    if (llGetListLength(fn) > 2) {
                        argLength = llList2Integer(fn, 2);
                    }

                    list fnArguments = llList2List(split, i+1, i+argLength);
                    string fnName = llList2String(fn, 1);
                    if (fnName == "llSetPrimitiveParams") {
                        params += fnArguments;
                    }

                    i = i + argLength;
                    jump nextTexture;
                }

                if (faceProcessed < faceLength) {
                    faceProcessed = faceProcessed + 1;
                    list each_face = llParseString2List(llList2String(faces, faceProcessed-1), [","], []);

                    integer face_length = llGetListLength(each_face);
                    integer face_i;
                    for (face_i = 0; face_i < face_length; face_i += 1) {
                        string one_face;

                        one_face = llList2String(each_face, face_i);
                        if (one_face == "ALL_SIDES") {
                            params += PrimitiveParamsTexture(ALL_SIDES, face_texture);
                        } else {
                            params += PrimitiveParamsTexture((integer)one_face, face_texture);
                        }
                    }
                }
                @nextTexture;
            }

            if (llGetListLength(params) > 0) {
                llSetLinkPrimitiveParamsFast(LINK_THIS, params);
            }
        }
    }
}
