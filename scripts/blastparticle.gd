
extends KinematicBody2D

var image
var timer
var velocity = Vector2(0, 0)
var x
var y
var randx
var randy
var opacity = 1

func _ready():
	timer = get_node("timer")
	timer.connect("timeout", self, "_on_timeout")
	timer.set_wait_time(1)
	timer.start()
	
	image = get_node("sprite")
	
	randomize()
	x = rand_range(0, 200)
	y = rand_range(0, 200)
	
	randx = random_neg()
	randy = random_neg()
	
	var scale = rand_range(0.5, 1.5)
	set_scale(Vector2(1, 1) * scale)
	
	set_fixed_process(true)
	
	
func _fixed_process(delta):
	opacity -= 0.1
	set_opacity(opacity)
	
	velocity.x = (x - 2) * randx
	velocity.y = (y - 2) * randy
	
	move(velocity * delta)
	
	
func _on_timeout():
	queue_free()


func random_neg():
	randomize()
	var neg = rand_range(0, 10)
	if neg > 5:
		return 1
	else:
		return -1

