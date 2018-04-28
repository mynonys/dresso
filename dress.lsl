integer channel_constant = 38609;
list textures = [
    "huddo: RED", "04287ef5-e44c-438e-c121-77378f2a550f",
    "huddo: BLUE", "fe306cc3-75ee-911d-721d-a0b6deb441cf",
    "huddo: GREEN", "a5dcd191-bde1-a694-2bde-b83ffede11f3",
    "huddo: WHITE", "334fe89c-efe1-2de3-f7d2-ed18697155bc"
];

default {
    state_entry() {
        integer length = llGetListLength(textures);
        integer i;
        for (i = 0; i < length; i += 2) {
            llListen(channel_constant, llList2String(textures, i), NULL_KEY, llList2String(textures, i));
        }
    }

    listen(integer channel, string name, key id, string message)
    {
        integer position;
        position = llListFindList(textures, [message]);
        llSetTexture(llList2Key(textures, position + 1), ALL_SIDES);
    }
}
