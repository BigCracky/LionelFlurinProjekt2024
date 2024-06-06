//speeds
hsp = 0; // horizontale Geschwindigkeit, nennt man nicht hspeed
max_hsp = 5;  
vsp = 0; // vertikale Geschwindigkeit, nicht vspeed
grav = 0.5; // Hier fehlte das Semikolon

//TileMapCollision
my_tilemap = layer_tilemap_get_id("Tiles_1");

//player inputs
key_left = 0;
key_right = 0;
key_jump = 0;
key_jump_held = 0;

// jumping 
onground = false;
groundbuffer = 10; // Man darf springen, wenn man wenigstens 3 Pixel in der Nähe ist
jumpspeed = -12; // Je negativer, desto höher
jumpbuffer = 4; // Frames nach dem Verlassen des Bodens, in denen man noch springen kann

// momentum 
accel = 0.5; // Beschleunigung
decel = 0.3; // Verzögerung

//JumpPad
JumpPadPower = 1.5;
JumpPadPowerSuper = 2.5;
