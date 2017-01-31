
extends KinematicBody2D


const GRAVITY = 40
const SPEED = 110
const JUMPHEIGHT = -600

var velocity = Vector2(0, 0)
var can_jump = false
var can_shoot = true
var direction = 1
var image
var animation
var detector
var hitarea
var hp = 3
var particle_class = preload('res://scenes/enemyfragment.tscn')
var enemyDeflector = preload('res://scripts/enemyDeflector.gd')
var bullet = preload('res://scripts/bullet.gd')



func _ready():
	animation = get_node("anim")
	image = get_node("animsprite")
	detector = get_node("detector")
	detector.connect("body_enter", self, "_on_detector_body_enter")
	
	hitarea = get_node("hitarea")
	hitarea.connect("body_enter", self, "_on_hit")
	
	
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	if velocity.x == 0:
		direction *= -1
		set_scale(Vector2(direction, 1))
	velocity.x = SPEED * direction
	velocity.y += GRAVITY
	
	var motion = velocity * delta
	motion = move(motion)
	
	if is_colliding():
		can_jump = true
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
		
		if not animation.is_playing():
			image.set_frame(5)
	else:
		can_jump = false
		if velocity.y <= 0:
			image.set_frame(5)
		else:
			image.set_frame(2)
			
	if hp <= 0:
		explode()
			
			
func _on_detector_body_enter(body):
	velocity.y = JUMPHEIGHT
	if body extends bullet:
		hp -= 1
	

func _on_hit(body):
	if body extends bullet:
		hp -= 1
		
		
func explode():
	for i in range(20):
		var particle = particle_class.instance()
		particle.set_pos(get_pos())
		get_parent().add_child(particle)
	queue_free()

