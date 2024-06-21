// Eingaben / Variablen
key_left = keyboard_check(ord("A")); // Prüft, ob die linke Taste (A) gedrückt wird
key_right = keyboard_check(ord("D")); // Prüft, ob die rechte Taste (D) gedrückt wird
key_jump = keyboard_check_pressed(ord("W")); // Prüft, ob die Sprungtaste (W) gerade gedrückt wurde
key_jump_held = keyboard_check(ord("W")); // Prüft, ob die Sprungtaste (W) gehalten wird

// Bewegungsrichtung bestimmen (-1 ist links, 1 ist rechts und 0 ist nichts)
var dir = key_right - key_left; // Berechnet die Bewegungsrichtung basierend auf den Richtungstasten

// Horizontale Geschwindigkeit
hsp += dir * accel; // Beschleunigt oder verlangsamt je nach Richtungstaste

if (dir == 0) { // Verlangsamen, wenn keine Richtungstaste gedrückt wird
    if (hsp < 0) {
        hsp = min(hsp + decel, 0); // Verlangsamt die Geschwindigkeit nach links
    } else {
        hsp = max(hsp - decel, 0); // Verlangsamt die Geschwindigkeit nach rechts
    }
}

hsp = clamp(hsp, -max_hsp, max_hsp); // Begrenzt die maximale Horizontale Geschwindigkeit

// Vertikale Bewegung
vsp += grav; // Fügt die Gravitation zur vertikalen Geschwindigkeit hinzu

// Ground jump 
if (jumpbuffer > 0) { // Überprüft, ob der Sprungpuffer größer als 0 ist
    jumpbuffer--; // Reduziert den Sprungpuffer
    if (key_jump) { // Überprüft, ob die Sprungtaste gedrückt wurde
        jumpbuffer = 0; // Setzt den Sprungpuffer auf 0 zurück, um Doppelsprünge zu verhindern
        vsp = jumpspeed; // Setzt die vertikale Geschwindigkeit für den Sprung
    }
}

// Horizontale Kollision
if (place_meeting(x + hsp, y, my_tilemap)) {
    var onepixel = sign(hsp); // Bestimmt die Richtung für Kollisionskorrekturen
    while (!place_meeting(x + onepixel, y, my_tilemap)) {
        x += onepixel; // Korrigiert die Kollision um einen Pixel
    }
    hsp = 0; // Stoppt die horizontale Bewegung
}

// Führt die horizontale Bewegung aus
x += hsp;

// Vertikale Kollision
if (place_meeting(x, y + vsp, my_tilemap)) {
    var onepixel = sign(vsp); // Bestimmt die Richtung für Kollisionskorrekturen
    while (!place_meeting(x, y + onepixel, my_tilemap)) {
        y += onepixel; // Korrigiert die Kollision um einen Pixel
    }
    vsp = 0; // Stoppt die vertikale Bewegung
}

// Führt die vertikale Bewegung aus
y += vsp;

// Statusberechnung
onground = place_meeting(x, y + groundbuffer, my_tilemap); // Überprüft, ob der Spieler den Boden berührt
if (onground) jumpbuffer = 10; // Setzt den Sprungpuffer, wenn der Spieler den Boden berührt

// Sprite-Anpassung
image_speed = 1; // Setzt die Bildgeschwindigkeit auf 100%

if (hsp != 0) { // Wenn der Spieler sich horizontal bewegt
    sprite_index = sPlayerRun; // Setzt den Lauf-Sprite
    image_xscale = sign(hsp); // Spiegelt den Sprite je nach Bewegungsrichtung
} else if (!onground) { // Wenn der Spieler in der Luft ist
    sprite_index = sPlayerAir; // Setzt den Luft-Sprite
    image_speed = 0; // Stoppt die Animation
    image_index = (vsp > 0); // Setzt den Frame basierend auf der vertikalen Bewegungsrichtung
} else { // Wenn der Spieler steht
    sprite_index = sPlayer; // Setzt den Stand-Sprite
}

// Spiel spielen / Neustarten
if (keyboard_check_pressed(vk_enter)) {
    room_restart(); // Startet das Level neu
}

// Ins Tutorial gehen
if (keyboard_check(vk_shift)) {
    room_goto(rLevelTutorial); // Wechselt zum Tutorial-Level
}

// Überprüft, ob die Tür entsperrt ist und der Spieler mit der Tür kollidiert
if (locked == false && place_meeting(x, y, oDoor)) {
    room_goto_next(); // Wechselt zum nächsten Level
    locked = true; // Sperrt die Tür wieder
}

// Stoppt die Spielmusik im Menü
if (room == rMenu) {
    audio_stop_sound(sndBackgroundmusic); // Stoppt die Hintergrundmusik
    audio_stop_sound(sndFinishMusic); // Stoppt die Endmusik
}
