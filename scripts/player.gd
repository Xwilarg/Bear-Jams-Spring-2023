class_name Player
extends CharacterBody2D
# submarine


const GRAVITY = 50.0
const DRAG = 10.0
const MAX_VELOCITY = 200.0

var thrust = 100.0
var sr: Sprite2D

func _ready():
	sr = $"./Sprite2D"

func _physics_process(delta):
	# add gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# add thrust
	var y_direction = Input.get_axis("move_up", "move_down")
	if y_direction:
		velocity.y += y_direction * thrust * delta
		
	else:
		velocity.y = move_toward(velocity.y, 0, DRAG * delta)
	
	var x_direction = Input.get_axis("move_left", "move_right")
	if x_direction:
		velocity.x += x_direction * thrust * delta
		
	else:
		velocity.x = move_toward(velocity.x, 0, DRAG * delta)
	
	# clamp velocity
	velocity = velocity.clamp(Vector2(-MAX_VELOCITY, -MAX_VELOCITY), Vector2(MAX_VELOCITY, MAX_VELOCITY))
	
	move_and_slide()
	
	sr.flip_h = velocity.x < 0
