integer channel_constant = 38609;
string unique_name = "A Unique Name";
list textures = [
    "04287ef5-e44c-438e-c121-77378f2a550f",
    "fe306cc3-75ee-911d-721d-a0b6deb441cf"
//  "fn:llSetPrimitiveParams",
//  PRIM_COLOR,
//  ALL_SIDES,
//  <255,255,255>,
//  0.80
];

list List2TypedList(list untyped) {
	list typed = [];
	integer length = llGetListLength(untyped);
	integer i;

	for (i = 0; i < length; i++) {
		typed += [ llGetListEntryType(untyped, i), llList2String(untyped, i) ];
	}

	return typed;
}

default {
    state_entry() {
    }

    touch_start(integer discard){
        llRegionSayTo( llGetOwner(), channel_constant, llList2CSV([unique_name] + List2TypedList(textures)) );
    }
}
