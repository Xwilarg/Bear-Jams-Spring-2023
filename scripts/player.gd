class_name Player
extends RigidBody2D

const MAX_VELOCITY = 150.0

var thrust = 10.0

var prevVel = Vector2.ZERO

@onready var sprite = %Sprite2D
var x_direction

@export var net: PackedScene
@export var light: ColorRect

var net_reload_timer = 0.0;
const NET_RELOAD_REF = 2.0;

func _process(delta):
	net_reload_timer -= delta

	light.material.set_shader_parameter("ar", get_viewport_rect().size.y / get_viewport_rect().size.x)
	light.material.set_shader_parameter("position", Vector2.ONE / 2)

	if x_direction == null:
		return

	if sprite.flip_h and x_direction > 0:
		sprite.flip_h = false
	elif (not sprite.flip_h) and x_direction < 0:
		sprite.flip_h = true

	if Input.is_action_just_pressed("fire") and net_reload_timer <= 0.0:
		var go = net.instantiate()
		get_parent().add_child(go)
		go.position = position
		var x = -1 if sprite.flip_h else 1
		(go as RigidBody2D).add_constant_central_force(Vector2(3 * x, -1).normalized() * 350)
		(go.get_node("Sprite2D") as Sprite2D).flip_h = x
		net_reload_timer = NET_RELOAD_REF


func _integrate_forces( state ):
	var velocity = Vector2.ZERO

	# add thrust
	var y_direction = Input.get_axis("move_up", "move_down")
	if y_direction:
		if (y_direction < 0 && velocity.y > 0) || (y_direction > 0 && velocity.y < 0):
			y_direction *= 2
		velocity.y += y_direction * thrust

	x_direction = Input.get_axis("move_left", "move_right")
	if x_direction:
		if (x_direction < 0 && velocity.x > 0) || (x_direction > 0 && velocity.x < 0):
			x_direction *= 2
		velocity.x += x_direction * thrust

	linear_velocity += velocity
	
	# clamp velocity
	linear_velocity = linear_velocity.clamp(Vector2(-MAX_VELOCITY, -MAX_VELOCITY), Vector2(MAX_VELOCITY, MAX_VELOCITY))
	
	if(state.get_contact_count() >= 1):
		if state.get_contact_collider_object(0).name == "Fish":
			var fish = (state.get_contact_collider_object(0) as Fish)
			var p = (position - state.get_contact_local_position(0)).normalized() * 1000.0
			linear_velocity += p
			fish.propulse(-p / 5)
			fish.collect()

	prevVel = linear_velocity
