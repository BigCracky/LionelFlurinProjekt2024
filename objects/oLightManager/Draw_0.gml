// Zeichnen der Licht-Surface im Draw-Event

// Save the current target surface
var old_target = surface_get_target();

// Set the light surface as the target
surface_set_target(light_surface);

// Clear the surface with black
draw_clear(c_black);

// Set the blend mode to subtract to create the light effect
gpu_set_blendmode(bm_subtract);

// Draw the light circle around the player
draw_set_color(c_white);
var light_radius = 150; // Adjust the radius as needed
draw_circle_color(oPlayer.x, oPlayer.y, light_radius, c_white, c_black, false);

// Reset the blend mode
gpu_set_blendmode(bm_normal);

// Reset the target surface to the previous target
surface_reset_target();

// Draw the entire screen with the light surface overlay
draw_surface(light_surface, 0, 0);
