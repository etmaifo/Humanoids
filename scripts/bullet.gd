
extends KinematicBody2D

var timer

func _ready():
	timer = get_node("timer")
	timer.connect("timeout", self, "_on_timeout")
	timer.set_wait_time(2)
	timer.start()
	
	set_fixed_process(true)
	
	
func _fixed_process(delta):
	pass
	
	
func _on_timeout():
	queue_free()


