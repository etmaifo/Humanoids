
extends Area2D

var particle_class = preload('res://scenes/blastparticle.tscn')
var animation
var particles = []

func _ready():
	animation = get_node("anim")
	
	for i in range(5):
		var particle = particle_class.instance()
		particle.set_pos(get_pos())
		get_parent().add_child(particle)
		
		set_fixed_process(true)
		

func _fixed_process(delta):
	if not animation.is_playing():
		queue_free()
		
		



