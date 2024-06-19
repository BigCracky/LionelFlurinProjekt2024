if (light_surface != -1) {
    if (!surface_exists(light_surface)) {
        light_surface = -1;
    }
}

if (light_surface == -1) {
    light_surface = surface_create(room_width, room_height);
}
