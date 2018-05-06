# Dresso
a Simple Texture Change HUD Script

**IMPORTANT NOTE: It is vital that the `button` script not be given Mod
permissions when distributed. If a user is able to see the texture UUIDs
within the `button` script, they will effectively have full C/M/T
permission on those textures.**

## Purpose
When configured properly, clicking a button on a HUD will change one or
more textures on an item of clothing.

## Components
There are two scripts:

 - The "button" script goes into whatever prim is to be clicked (eg, a
   button on a HUD)
 - The "dress" script goes into whatever is to change textures (eg, an
   item of clothing)

## Script Configuration
 - `channel_constant`: must be the same in both scripts. It should be
   changed to a random number between -2147483648 and -1024. It is
   recommended you use a random number generator to create this number.
   This number should usually be the same for every copy of Dresso that
   you use in your store.
 - `unique_name`: must be the same in both scripts. It should uniquely
   identify an item you sell, such as a single piece of clothing.
 - `textures`: set in the button script. This is a list of texture UUIDs
   to set on the "dress" object when the button prim is clicked. 
 - `faces`: set in the dress script. This is a list of faces the
   textures will be assigned to when the button prim is clicked.

## "Faces" List Format
The `faces` list indicates which face each texture will be assigned to.
The faces which are listed in the `faces` list will be given the
corresponding texture from the `textures` list when the button prim is
clicked.

Each element of the `faces` list is a string. The string may be either
an individual face number, a comma-separated list of face numbers, or
the special string "ALL_SIDES".

The `faces` list is processed in-order, with later entries overriding
earlier entries. So, for example:

    faces = ["1,2,3", "3"];

Would cause face `3` to receive the second texture in the `textures`
list. With this in mind, the "ALL_SIDES" face indicates that the
corresponding texture should be use as a "default" for otherwise
unspecified faces. When used, it should always be given as the first
face in the list.

## More-Advanced Usage

### Changing Things Other Than Textures
Setting a texture with the name `fn:llSetPrimitiveParams` will cause
all subsequent entries in the texture list to act as if they had been
sent to the [`llSetPrimitiveParams`](http://wiki.secondlife.com/wiki/LlSetPrimitiveParams) function
on the "dress" script's object. The list is sent directly, without
additional processing, so face numbers will need to be included when
relevant.

### Setting Textures on Multiple Objects with a Single Button
In order to change the textures of multiple objects with a single
button, you can add multiple copies of the `button` script. into the
button. Each `button` script should have its own `unique_name` to match
the `unique_name` in the corresponding `dress` script in the prim you
wish to change the textures of.

### Mixing and Matching HUDs with Releases
When you re-use a mesh for multiple releases, you can allow the use of
new HUDs to use across the different items of clothing. For example, if
you release different colour sets, as well as a "fat pack" including all
colours on the same HUD, the "fat pack" HUD could be made to be
interchangeable with the smaller "sets" without requiring the clothing
be changed. In order to achieve this, ensure the same `unique_name` and
`channel_constant` are used across all scripts which are meant to be
compatible.

Note that as a general rule, scripts will only be compatible when the
"major version number" (number before the decimal point) is the same. If
the major version is different, scripts may behave unpredictably.
