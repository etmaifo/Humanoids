
extends KinematicBody2D


const GRAVITY = 40
const SPEED = 200
const JUMPHEIGHT = -600
const LEFT = "left"
const RIGHT = "right"

var velocity = Vector2(0, 0)
var can_jump = false
var direction = RIGHT
var rect
var x
var y
var left
var right

var bullet_class = preload('res://scenes/bullet.tscn')

func _ready():
	var image = get_node("sprite").get_texture()
	rect = image.get_size()
	x = get_pos().x
	y = get_pos().y
	left = x
	right = x + rect.width
	set_fixed_process(true)
	set_process_input(true)
	
	
func _fixed_process(delta):
	velocity.y += GRAVITY
	
	var motion = velocity * delta
	motion = move(motion)
	
	if is_colliding():
		can_jump = true
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
	else:
		can_jump = false
		
		
func _input(event):
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
		direction = LEFT
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
		direction = RIGHT
		
	else:
		velocity.x = 0
		
	if Input.is_action_pressed("jump") and can_jump:
		velocity.y = JUMPHEIGHT
		
	if Input.is_action_pressed("shoot"):
		var bullet = bullet_class.instance()
		get_parent().add_child(bullet)
		if direction == RIGHT:
			bullet.set_pos(Vector2(get_pos().x + rect.width + 20, get_pos().y))
		elif direction == LEFT:
			bullet.set_pos(Vector2(get_pos().x - 20, get_pos().y))
			



