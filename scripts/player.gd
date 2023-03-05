class_name Player
extends RigidBody2D
# player controlled character


# values read by hud
@export var health: int = 3
var pressure: float


const MAX_VELOCITY = 150.0
const DRAG = 2.0

var thrust = 10.0

var prevVel = Vector2.ZERO
var originalPos: Vector2

var x_direction


@export var net: PackedScene

var net_reload_timer = 0.0;
const NET_RELOAD_REF = 2.0;


@onready var sprite = %Sprite2D
@export var shootAudioPlayer: AudioStreamPlayer2D

var broken = false

@onready var brokenTexture = %BrokenSprite

func _ready():
	originalPos = global_position

func _process(delta):
	if broken:
		return
	
	net_reload_timer -= delta
	
	if Input.is_action_just_pressed("reset"):
		global_position = originalPos
		linear_velocity = Vector2.ZERO
	
	# pressure = depth?
	pressure = (position.y + 900.0) * 100.0 / 4800.0
	
	# animation
	if Input.is_action_pressed("move_down") \
			or Input.is_action_pressed("move_left") \
			or Input.is_action_pressed("move_right") \
			or Input.is_action_pressed("move_up"):
		if sprite.frame == 0:
			sprite.frame = 1
			
	else:
		if sprite.frame == 1:
			sprite.frame = 0
	
	if x_direction == null:
		return
	
	if sprite.flip_h and x_direction > 0:
		sprite.flip_h = false
	elif (not sprite.flip_h) and x_direction < 0:
		sprite.flip_h = true
	
	if Input.is_action_just_pressed("fire") and net_reload_timer <= 0.0:
		shootAudioPlayer.play()
		var go = net.instantiate()
		get_parent().add_child(go)
		go.position = position
		var x = -1 if sprite.flip_h else 1
		(go as RigidBody2D).add_constant_central_force(Vector2(3 * x, -1).normalized() * 350)
		(go.get_node("Sprite2D") as Sprite2D).flip_h = x
		net_reload_timer = NET_RELOAD_REF


func _integrate_forces( state ):
	if broken:
		return
	
	var velocity = Vector2.ZERO

	# add thrust
	var y_direction = Input.get_axis("move_up", "move_down")
	if y_direction:
		if (y_direction < 0 && velocity.y > 0) || (y_direction > 0 && velocity.y < 0):
			y_direction *= 2
		velocity.y += y_direction * thrust
	else:
		linear_velocity.y = move_toward(linear_velocity.y, 0, DRAG)

	x_direction = Input.get_axis("move_left", "move_right")
	if x_direction:
		if (x_direction < 0 && velocity.x > 0) || (x_direction > 0 && velocity.x < 0):
			x_direction *= 2
		velocity.x += x_direction * thrust
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, DRAG)

	linear_velocity += velocity
	
	# clamp velocity
	linear_velocity = linear_velocity.clamp(Vector2(-MAX_VELOCITY, -MAX_VELOCITY), Vector2(MAX_VELOCITY, MAX_VELOCITY))

	if(state.get_contact_count() >= 1):
		if state.get_contact_collider_object(0).name.begins_with("Fish"):
			var fish = (state.get_contact_collider_object(0) as Fish)
			if fish.can_collect():
				fish.queue_free()
			else:
				var p = (position - fish.position).normalized() * 1000.0
				linear_velocity += p / 20
				fish.propulse(-p / 5)
				# take damage if colliding with fish?
				take_damage(1)

	prevVel = linear_velocity


func take_damage(amount: int):
	if not %InvincibleTimer.is_stopped():
		return
		
	health -= amount
	%InvincibleTimer.start()
	if health == 0:
		broken = true
		brokenTexture.visible = true
		sprite.visible = false
