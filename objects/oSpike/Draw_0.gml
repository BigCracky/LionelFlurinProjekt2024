// Draw event code for the object on the instance layer
if (point_in_circle(x, y, oPlayer.x, oPlayer.y, 150)) {
    draw_self(); // Zeichne das Objekt nur, wenn es sich innerhalb des Lichtkegels befindet
}
