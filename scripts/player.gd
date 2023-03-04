class_name Player
extends CharacterBody2D
# submarine


const GRAVITY = 50.0
const DRAG = 10.0
const MAX_VELOCITY = 200.0

var thrust = 100.0

@onready var sprite = %Sprite2D
var x_direction

@export var net: PackedScene


func _process(_delta):
	if x_direction == null:
		return

	if sprite.flip_h and x_direction > 0:
		sprite.flip_h = false
	elif (not sprite.flip_h) and x_direction < 0:
		sprite.flip_h = true

	if Input.is_action_just_pressed("fire"):
		var go = net.instantiate()
		get_parent().add_child(go)
		go.position = position
		var x = -1 if sprite.flip_h else 1
		(go as RigidBody2D).add_constant_central_force(Vector2(3 * x, -1).normalized() * 350)
		(go.get_node("Sprite2D") as Sprite2D).flip_h = x


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
	
	x_direction = Input.get_axis("move_left", "move_right")
	if x_direction:
		velocity.x += x_direction * thrust * delta
		
	else:
		velocity.x = move_toward(velocity.x, 0, DRAG * delta)
	
	# clamp velocity
	velocity = velocity.clamp(Vector2(-MAX_VELOCITY, -MAX_VELOCITY), Vector2(MAX_VELOCITY, MAX_VELOCITY))
	
	move_and_slide()
