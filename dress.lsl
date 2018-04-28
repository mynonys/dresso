integer channel_constant = 38609;
string unique_name = "A Unique Name";
list faces = ["ALL_SIDES", "1,2,3"];

default {
    state_entry() {
        llListen(channel_constant, "", NULL_KEY, "");
    }

    listen(integer channel, string name, key id, string message)
    {
        list split = llParseString2List(message, [","], []);
        integer length = llGetListLength(split);
        if (length == llGetListLength(faces)+1 && llList2String(split, 0) == unique_name) {
            integer i;
            for (i = 1; i < length; i += 1) {
                string face_texture = llList2String(split, i);
                list each_face = llParseString2List(llList2String(faces, i-1), [","], []);

                integer face_length = llGetListLength(each_face);
                integer face_i;
                for (face_i = 0; face_i < face_length; face_i += 1) {
                    string one_face;
                    one_face = llList2String(each_face, face_i);
                    if (one_face == "ALL_SIDES") {
                        llSetTexture(face_texture, ALL_SIDES);
                    } else {
                        llSetTexture(face_texture, (integer)one_face);
                    }
                }
            }
        }
    }
}
