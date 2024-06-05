// Inputs / Variabel um zu sehen wann die "Knöpfe" gedrückt werden
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_up);
key_jump_held = keyboard_check(vk_up);

// Bewegungsrichtung bestimmen (-1 ist links, 1 ist rechts und 0 ist nichts)
var dir = key_right - key_left; // das ist, wenn beide links und rechts gedrückt werden, dass es 0 ergibt (nichts passiert)

// Horizontale Geschwindigkeit bestimmen (negative hsp bedeutet links, positive bedeutet rechts)
hsp += dir * accel;

if (dir == 0) { // Verlangsamen, wenn keine Richtungstaste gedrückt wird
    if (hsp < 0) {
        hsp = min(hsp + decel, 0);
    } else { // Nach rechts gehend
        hsp = max(hsp - decel, 0);
    }
}

hsp = clamp(hsp, -max_hsp, max_hsp); // Maximalgeschwindigkeit festlegen, links oder rechts, wird im Create-Event definiert

// Vertikale Bewegung berechnen
vsp += grav;

//ground jump 
if (jumpbuffer > 0) { //check if the jump is greater than 0 
	jumpbuffer--;   // reduced jumbuffer variable by 1 each step
	if (key_jump) { //check if jump key was pressed
		jumpbuffer = 0; //set jump buffer =0 (das mer nd 2 mal springe chan)
		vsp = jumpspeed; 
	}	
}

// Horizontale Kollision
if (place_meeting(x + hsp, y, oBlock)) {
    var onepixel = sign(hsp);
    while (!place_meeting(x + onepixel, y, oBlock)) {
        x += onepixel;
    }
    hsp = 0;	
}

// Horizontale Bewegung ausführen
x += hsp;

// Vertikale Kollision
if (place_meeting(x, y + vsp, oBlock)) {
    var onepixel = sign(vsp);
    while (!place_meeting(x, y + onepixel, oBlock)) {
        y += onepixel;
    }
    vsp = 0;	
}

// Vertikale Bewegung ausführen
y += vsp;

//Calculate c. Status
onground = place_meeting(x,y+groundbuffer,oBlock);
if (onground) jumpbuffer = 10;
//quick restart game

if (keyboard_check_pressed(vk_enter)) {
	game_restart();
}