
extends Node2D

var camera
var velocity = Vector2(0, 0)

func _ready():
	camera = get_node("camera")
	
	set_fixed_process(true)



func _fixed_process(delta):
	velocity.x += 1
	
	camera.set_pos(velocity)