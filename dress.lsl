integer channel_constant = 38609;
string unique_name = "A Unique Name";
list sides = ["ALL_SIDES", "1,2,3"];

default {
    state_entry() {
        llListen(channel_constant, "", NULL_KEY, "");
    }

    listen(integer channel, string name, key id, string message)
    {
        list split = llParseString2List(message, [","], []);
        integer length = llGetListLength(split);
        if (length == llGetListLength(sides)+1 && llList2String(split, 0) == unique_name) {
            integer i;
            for (i = 1; i < length; i += 1) {
                string side_texture = llList2String(split, i);
                list each_side = llParseString2List(llList2String(sides, i-1), [","], []);

                integer side_length = llGetListLength(each_side);
                integer side_i;
                for (side_i = 0; side_i < side_length; side_i += 1) {
                    string one_side;
                    one_side = llList2String(each_side, side_i);
                    if (one_side == "ALL_SIDES") {
                        llSetTexture(side_texture, ALL_SIDES);
                    } else {
                        llSetTexture(side_texture, (integer)one_side);
                    }
                }
            }
        }
    }
}
