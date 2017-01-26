
extends Node2D

var player
var ground
var camera

func _ready():
	player = get_node("player")
	ground = get_node("ground")
	camera = get_node("camera")

	set_fixed_process(true)
	set_process_input(true)
	

func _fixed_process(delta):
	var playerx = player.get_pos().x
	var playery = player.get_pos().y
	var camx = 0
	var camy = 0
	if (playerx > 240):
		camx  = playerx - 240
	else:
		camx = 0
		
	if playery > 360 or playery < 90:
		camy = playery - 180
	else:
		camy = 0
	camera.set_pos(Vector2(camx, camy))
	
	
func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


