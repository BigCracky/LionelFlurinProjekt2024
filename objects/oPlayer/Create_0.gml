//speeds
hsp = 0; // horizontalle geschwindigkeit, nennt man nicht hspeed
max_hsp = 5;  
vsp = 0; //vertical speed variablle, not called vspeed
grav = 0.5

//TileMapCollison

my_tilemap = layer_tilemap_get_id("Tiles_1");


//player inputs

key_left = 0 
key_right = 0
key_jump = 0
key_jump_held = 0

// jumping 
onground=false
groundbuffer = 10; //man darf springen wenn man wenigsten 3 pixel in der nahe ist
jumpspeed = -12; //more negative equals higher
jumpbuffer = 4; //frames after leaving the ground where we can still jump
// momentum 

accel = 0.5; //an acceleration variable die als 0.5 definiert worden ist
decel = 0.3; //deceleration 

//JumpPad

JumpPadPower = 1.5
JumpPadPowerSuper = 2.5

//Tuere 
locked = true

//Licht
light_radius = 150
