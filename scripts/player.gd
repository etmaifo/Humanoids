
extends KinematicBody2D


const GRAVITY = 40
const SPEED = 200
const JUMPHEIGHT = -600

var velocity = Vector2(0, 0)
var can_jump = false

func _ready():
	
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
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
		
	else:
		velocity.x = 0
		
	if Input.is_action_pressed("jump") and can_jump:
		velocity.y = JUMPHEIGHT



