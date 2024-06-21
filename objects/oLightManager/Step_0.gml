if (light_surface != -1) {
    if (!surface_exists(light_surface)) {
        light_surface = -1;
    }
}

if (light_surface == -1) {
    light_surface = surface_create(room_width, room_height);
}

if (light_surface != -1) {                     
    if (!surface_exists(light_surface)) {
        light_surface = -1;
    }
}

if (light_surface == -1) {
    light_surface = surface_create(room_width, room_height);
}

if (visited_surface != -1) {
    if (!surface_exists(visited_surface)) {
        visited_surface = -1;
    }
}

if (visited_surface == -1) {
    visited_surface = surface_create(room_width, room_height);
}
