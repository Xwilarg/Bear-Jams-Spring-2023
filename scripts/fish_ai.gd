extends RigidBody2D

class_name Fish

enum Behavior { BEHAV_IDLE, BEHAV_PATROL, BEHAV_CHASE }

@export var Speed: float
@export var MinDistance: int
@export var MyBehavior: Behavior
@onready var rayContainer = $"Rays"
@onready var rays = $"Rays".get_children()

var next: NextNode
var lastNode: NextNode
var normals: Array[Sprite2D]
var stunned: Array[Sprite2D]

var can_move: bool = true
var last_player_pos: Vector2
var is_chasing = false

var stun_timer = 0.0

var target_index = 0

func _process(delta):
	if stun_timer > 0.0:
		stun_timer -= delta
		if stun_timer <= 0.0:
			get_closest_node(last_player_pos)

	if MyBehavior == Behavior.BEHAV_IDLE or MyBehavior == Behavior.BEHAV_PATROL:
		return

	for ray in rays:
		var c = (ray as RayCast2D).get_collider()
		if c != null and c.name == "Player":
			is_chasing = true
			last_player_pos = c.global_position
			print(name + " is chasing player")
			return

	if is_chasing:
		is_chasing = false
		print(name + " lost player")
		get_closest_node(last_player_pos)

func get_closest_node(pos: Vector2):
	var filter := func distanceComparaison(a: Node2D, b: Node2D):
		return pos.distance_to(a.global_position) < pos.distance_to(b.global_position)
	
	var targetNodes = get_tree().get_current_scene().get_node("AINodes").get_children()
	targetNodes.sort_custom(filter)
	next = targetNodes[0]
	print(name + " going to " + next.name)

func _ready():
	normals = [
		$"./CuttleFish/Normal" as Sprite2D,
		$"./Isopod/Normal" as Sprite2D,
		$"./Nautilus/Normal" as Sprite2D,
		$"./Ray/Normal" as Sprite2D
	]
	stunned = [
		$"./CuttleFish/Stunned" as Sprite2D,
		$"./Isopod/Stunned" as Sprite2D,
		$"./Nautilus/Stunned" as Sprite2D,
		$"./Ray/Stunned" as Sprite2D
	]
	normals[target_index].get_parent().visible = true
	lastNode = null

	get_closest_node(global_position)

func _integrate_forces(state):
	if !can_move || stun_timer > 0.0:
		return

	var target: Vector2
	var currSpeed = Speed
	if is_chasing && MyBehavior == Behavior.BEHAV_CHASE:
		target = last_player_pos
		currSpeed *= 1.3
	else:
		target = next.global_position

	linear_velocity = (target - global_position).normalized() * currSpeed
	if global_position.distance_to(next.global_position) < MinDistance:
		if MyBehavior == Behavior.BEHAV_IDLE:
			linear_velocity = Vector2.ZERO
		elif !is_chasing:
			var tmp = lastNode
			lastNode = next
			next = next.getRandomNext(tmp)
	normals[target_index].flip_h = linear_velocity.x > 0
	var x_scale = 1 if linear_velocity.x > 0 else -1
	(rayContainer as Node2D).scale = Vector2(x_scale, 1)

func get_hit():
	can_move = false
	linear_velocity = Vector2.ZERO
	gravity_scale = 1.0
	set_collision_mask_value(3, true)
	normals[target_index].visible = false
	stunned[target_index].visible = true
	stunned[target_index].flip_h = normals[target_index].flip_h

func can_collect():
	return !can_move

func propulse(dir: Vector2):
	stun_timer = 2.0
	linear_velocity += dir

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Wow yet another Godot bug, can't disconnect this method so it's staying here empty forever
