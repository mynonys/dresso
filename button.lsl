integer channel_constant = 38609;
string unique_name = "A Unique Name";
list textures = [
    "04287ef5-e44c-438e-c121-77378f2a550f",
    "fe306cc3-75ee-911d-721d-a0b6deb441cf"
    //"a5dcd191-bde1-a694-2bde-b83ffede11f3",
    //"334fe89c-efe1-2de3-f7d2-ed18697155bc"
];

default {
    state_entry() {
    }

    touch_start(integer discard){
        llRegionSayTo( llGetOwner(), channel_constant, unique_name + "," + llDumpList2String(textures, ",") );
    }
}
