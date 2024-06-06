// Größe und Position der Oberfläche einstellen
if (global.lights_surface == -1) {
    global.lights_surface = surface_create(room_width, room_height);
}

// Oberfläche zur Lichtdarstellung verwenden
surface_set_target(global.lights_surface);
draw_clear_alpha(c_black, 1);

// Zeichne alle Lichtobjekte
with (oLightSkull1) {
    draw_self();
}

// Zieloberfläche zurücksetzen
surface_reset_target();
