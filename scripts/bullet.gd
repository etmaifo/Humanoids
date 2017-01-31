
extends KinematicBody2D

const SPEED = 700

var timer
var direction = 1
var velocity = Vector2(0, 0)

var blast_class = preload('res://scenes/blast.tscn')
var enemy = preload('res://scripts/enemyWalker.gd')


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
		var blast = blast_class.instance()
		blast.set_pos(get_pos())
		get_parent().add_child(blast)
		queue_free()
	
	
func _on_timeout():
	queue_free()


