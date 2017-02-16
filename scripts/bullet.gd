
extends KinematicBody2D

const SPEED = 700

var timer
var direction = 1
var velocity = Vector2(0, 0)

var collider

var blast_class = preload('res://scenes/blast.tscn')
var enemy = preload('res://scripts/enemyWalker.gd')


func _ready():
	timer = get_node("timer")
	timer.connect("timeout", self, "_on_timeout")
	timer.set_wait_time(2)
	timer.start()
	
	collider = get_node("Area2D")
	collider.connect("area_enter", self, "_on_collide")
	collider.connect("body_enter", self, "_on_body_enter")
	
	set_fixed_process(true)
	
	
func _fixed_process(delta):
	velocity.x = SPEED * direction
	move(velocity * delta)

	
	
func _on_timeout():
	queue_free()
	
func _on_collide(area):
	if area.get_parent() extends enemy:
		area.get_parent().hp -= 1
			
	var blast = blast_class.instance()
	blast.set_pos(get_pos())
	get_parent().add_child(blast)
	queue_free()

func _on_body_enter(body):	
	if body extends StaticBody2D or body extends TileMap:
		var blast = blast_class.instance()
		blast.set_pos(get_pos())
		get_parent().add_child(blast)
		queue_free()
