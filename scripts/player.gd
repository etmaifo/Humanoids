
extends KinematicBody2D


const GRAVITY = 40
const SPEED = 200
const JUMPHEIGHT = -700
const LEFT = "left"
const RIGHT = "right"

var velocity = Vector2(0, 0)
var can_jump = false
var can_shoot = true
var direction = RIGHT
var rect
var x
var y
var left
var right
var gun_trigger
var image
var animation
var dead = false

var bullet_class = preload('res://scenes/bullet.tscn')
var killerblock = preload('res://scripts/killerblock.gd')

func _ready():
	gun_trigger = get_node("timer")
	gun_trigger.connect("timeout", self, "_on_shot")
	
	animation = get_node("anim")
	image = get_node("animsprite")
	x = get_pos().x
	y = get_pos().y
	set_fixed_process(true)
	set_process_input(true)
	
	
func _fixed_process(delta):
	if dead:
		set_fixed_process(false) # disable
	velocity.y += GRAVITY
	
	var motion = velocity * delta
	motion = move(motion)
	
	if is_colliding():
		if (get_collider() extends killerblock):
			dead = true
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
		
		
func _input(event):
	if Input.is_action_pressed("move_left"):
		if not animation.is_playing():
			animation.play("walk")
			
		velocity.x = -SPEED
		direction = LEFT
		image.set_flip_h(true)
		
	elif Input.is_action_pressed("move_right"):
		if not animation.is_playing():
			animation.play("walk")
			
		velocity.x = SPEED
		direction = RIGHT
		if image.is_flipped_h():
			image.set_flip_h(false)
	else:
		velocity.x = 0
		animation.stop()
		
	if Input.is_action_pressed("jump") and can_jump:
		velocity.y = JUMPHEIGHT
		
	if Input.is_action_pressed("shoot") and can_shoot:
		var bullet = bullet_class.instance()
		get_parent().add_child(bullet)
		if direction == RIGHT:
			bullet.set_pos(Vector2(get_pos().x + 16, get_pos().y))
			bullet.direction = 1

		elif direction == LEFT:
			bullet.set_pos(Vector2(get_pos().x - 16, get_pos().y))
			bullet.direction = -1
			
			
		can_shoot = false
		gun_trigger.set_wait_time(0.1)
		gun_trigger.start()
		
	

func _on_shot():
	can_shoot = true



