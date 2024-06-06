#macro RES_W 960
#macro RES_H 540
#macro RES_SCALE 2

#macro CAM_SMOOTH 0.05

view_enabled = true;
view_visible = true;

camera = camera_create_view(0, 0, RES_W, RES_H);

view_set_camera(0,camera);

display_set_gui_size(RES_W, RES_H);
