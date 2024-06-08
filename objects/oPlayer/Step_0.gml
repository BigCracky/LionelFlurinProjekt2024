// ---------------------------
// Eingaben / Variablen
// ---------------------------
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_jump = keyboard_check_pressed(ord("W"));
key_jump_held = keyboard_check(ord("W"));

// Bewegungsrichtung bestimmen (-1 ist links, 1 ist rechts und 0 ist nichts)
var dir = key_right - key_left; // Wenn beide links und rechts gedrückt werden, ergibt es 0 (nichts passiert)

// ---------------------------
// Horizontale Geschwindigkeit
// ---------------------------
hsp += dir * accel;

if (dir == 0) { // Verlangsamen, wenn keine Richtungstaste gedrückt wird
    if (hsp < 0) {
        hsp = min(hsp + decel, 0); // Nach links gehend
    } else { 
        hsp = max(hsp - decel, 0); // Nach rechts gehend
    }
}

hsp = clamp(hsp, -max_hsp, max_hsp); // Maximalgeschwindigkeit festlegen, links oder rechts, wird im Create-Event definiert

// ---------------------------
// Vertikale Bewegung
// ---------------------------
vsp += grav;

// Ground jump 
if (jumpbuffer > 0) { // Überprüfen, ob der Sprungpuffer größer als 0 ist
    jumpbuffer--;   // Sprungpuffer um 1 verringern
    if (key_jump) { // Überprüfen, ob die Sprungtaste gedrückt wurde
        jumpbuffer = 0; // Sprungpuffer auf 0 setzen (damit man nicht zweimal springen kann)
        vsp = jumpspeed; 
    }    
}

// ---------------------------
// Horizontale Kollision
// ---------------------------
if (place_meeting(x + hsp, y, my_tilemap)) {
    var onepixel = sign(hsp);
    while (!place_meeting(x + onepixel, y, my_tilemap)) {
        x += onepixel;
    }
    hsp = 0;    
}

// Horizontale Bewegung ausführen
x += hsp;

// ---------------------------
// Vertikale Kollision
// ---------------------------
if (place_meeting(x, y + vsp, my_tilemap)) {
    var onepixel = sign(vsp);
    while (!place_meeting(x, y + onepixel, my_tilemap)) {
        y += onepixel;
    }
    vsp = 0;    
}

// Vertikale Bewegung ausführen
y += vsp;

// ---------------------------
// Statusberechnung
// ---------------------------
onground = place_meeting(x, y + groundbuffer, my_tilemap);
if (onground) jumpbuffer = 10;

// ---------------------------
// Sprite-Anpassung
// ---------------------------
image_speed = 1; // 100% Bildgeschwindigkeit

// Wenn sich der Spieler bewegt, Sprite entsprechend der Bewegungsrichtung ausrichten
if (hsp != 0) image_xscale = sign(hsp);

if (!onground) { // In der Luft
    sprite_index = sPlayerAir;
    image_speed = 0;
    image_index = (vsp > 0); // Fallend = 1, alles andere = 0
} else { // Am Boden
    if (hsp != 0) { // Wenn sich der Spieler nach links oder rechts bewegt
        sprite_index = sPlayerRun;
    } else { // Steht still
        sprite_index = sPlayer;
    }
}

// ---------------------------
// Spiel schnell neu starten
// ---------------------------
if (keyboard_check_pressed(vk_enter)) {
    room_restart();
}

