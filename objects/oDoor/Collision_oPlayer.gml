// Überprüfen, ob die Tür entsperrt ist, wenn der Spieler sie berührt
if (room == rLevelTutorial && locked == false){
	room_goto(rLevel1);
}
if (locked == false) {
    room_goto_next(); // Wechsel zu nechstem level
}