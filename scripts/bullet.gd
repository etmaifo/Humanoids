
extends KinematicBody2D

const SPEED = 1000

var timer
var direction = 1
var velocity = Vector2(0, 0)


func _ready():
	timer = get_node("timer")
	timer.connect("timeout", self, "_on_timeout")
	timer.set_wait_time(2)
	timer.start()
	
	set_fixed_process(true)
	
	
func _fixed_process(delta):
	velocity.x = SPEED * direction
	move(velocity * delta)
	
	if is_colliding():
		queue_free()
	
	
func _on_timeout():
	queue_free()


