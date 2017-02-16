
extends Node2D

var player
var ground
var camera
var overlay
var timer
var playOverlay = true

func _ready():
	player = get_node("player")
	ground = get_node("ground")
	camera = get_node("camera")
	overlay = get_node("overlayLayer/overlay")
	overlay.animation.play_backwards("closeIn")

	timer = get_node("timer")
	timer.connect("timeout", self, "_on_timeout")
	timer.set_wait_time(0)
	
	set_fixed_process(true)
	set_process_input(true)
	

func _fixed_process(delta):
	if player.dead and playOverlay:
		playOverlay = false
		timer.set_wait_time(2)
		timer.start()

			
	var playerx = player.get_pos().x
	var playery = player.get_pos().y
	var camx = 0
	var camy = 0
	if (playerx > 240):
		camx  = playerx - 240
	else:
		camx = 0
		
	if playery < 90:
		camy = playery - 180
	else:
		camy = 0
	camera.set_pos(Vector2(camx, camy))
	
	
func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func _on_animation_finished():
	player.dead = false
	get_tree().change_scene('res://scenes/game.tscn')
	
func _on_timeout():
	if not overlay.animation.is_playing():
		overlay.animation.play("closeIn")
		overlay.animation.connect("finished", self, "_on_animation_finished")