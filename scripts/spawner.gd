
extends Node2D


var timer
var enemy_class = preload('res://scenes/enemyWalker.tscn')

func _ready():
	timer = get_node("timer")
	timer.connect("timeout", self, "_on_timeout")
	timer.set_wait_time(10)
	timer.start()
	
	set_process(true)
	
	
func _process(delta):
	hide()
	
	
func _on_timeout():
	var enemy = enemy_class.instance()
	enemy.set_pos(get_pos())
	get_parent().add_child(enemy)
	
	randomize()
	var wait_time = int(rand_range(7, 15))
	timer.set_wait_time(wait_time)
	timer.start()


