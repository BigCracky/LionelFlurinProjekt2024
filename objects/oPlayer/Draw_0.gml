// Dunklen Hintergrund zeichnen
draw_clear(c_black);

// Zeichne den Lichtoberflächeninhalt
draw_surface(global.lights_surface, 0, 0);

// Zeichne den Charakter
draw_self();
