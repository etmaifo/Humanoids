
extends Node2D

var camera
var velocity = Vector2(0, 0)
var overlay

func _ready():
	camera = get_node("camera")
	overlay = get_node("overlayLayer/overlay")
	overlay.animation.connect("finished", self, "_on_animation_finished")
	
	set_fixed_process(true)
	set_process_input(true)


func _fixed_process(delta):
	velocity.x += 1	
	camera.set_pos(velocity)
	
	
func _input(event):
	if event.type == InputEvent.KEY or event.type == InputEvent.JOYSTICK_BUTTON:
		if not overlay.animation.is_playing():
			overlay.animation.play("closeIn")
			
		
func _on_animation_finished():
	get_tree().change_scene('res://scenes/game.tscn')