function scriptESC(){
	if keyboard_check_pressed(vk_escape){
	audio_stop_all();
	room_goto(rMenu);
	}
}	