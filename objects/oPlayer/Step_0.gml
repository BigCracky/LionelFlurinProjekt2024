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

// Ground jump 
if (jumpbuffer > 0) { // Check if the jump is greater than 0 
    jumpbuffer--;   // Reduce jumpbuffer variable by 1 each step
    if (key_jump) { // Check if jump key was pressed
        jumpbuffer = 0; // Set jump buffer to 0 (das mer nd 2 mal springe chan)
        vsp = jumpspeed; 
    }    
}

// Horizontale Kollision
if (place_meeting(x + hsp, y, oBlock) || place_meeting(x + hsp, y, oBlockHalf)) {
    var onepixel = sign(hsp);
    while (!place_meeting(x + onepixel, y, oBlock) && !place_meeting(x + onepixel, y, oBlockHalf)) {
        x += onepixel;
    }
    hsp = 0;    
}

// Horizontale Bewegung ausführen
x += hsp;

// Vertikale Kollision
if (place_meeting(x, y + vsp, oBlock) || place_meeting(x, y + vsp, oBlockHalf) || place_meeting(x, y + vsp, oJumpPad)) {
    var onepixel = sign(vsp);
    while (!place_meeting(x, y + onepixel, oBlock) && !place_meeting(x, y + onepixel, oBlockHalf) && !place_meeting(x, y + onepixel, oJumpPad)) {
        y += onepixel;
    }
    vsp = 0;

    // Zusatzsprung bei Kollision mit oJumpPad
    if (place_meeting(x, y + onepixel, oJumpPad)) {
        vsp = jumpspeed * JumpPadPower; // Beispiel: 1.5-fache Sprunggeschwindigkeit
    }
}

// Vertikale Bewegung ausführen
y += vsp;

// Calculate current Status
onground = place_meeting(x, y + groundbuffer, oBlock) || place_meeting(x, y + groundbuffer, oBlockHalf) || place_meeting(x, y + groundbuffer, oJumpPad);
if (onground) jumpbuffer = 10;

// Adjust Sprite Image
image_speed = 1; // 100% Image Speed
// If moving, orient sprite according to direction of movement
if (hsp != 0) image_xscale = sign(hsp);
if (!onground) {
    sprite_index = sPlayerAir;
    image_speed = 0;
    image_index = (vsp > 0); // Falling = 1, everything else = 0
} else { // If on the ground
    if (hsp != 0) { // If moving left or right 
        sprite_index = sPlayerRun;
    } else { // Standing still
        sprite_index = sPlayer;
    }
}

// Quick restart game
if (keyboard_check_pressed(vk_enter)) {
    game_restart();
}
