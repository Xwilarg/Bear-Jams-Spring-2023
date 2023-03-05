@tool
extends RigidBody2D

class_name Fish

@export var Speed: float
@export var MinDistance: int
@onready var rays = $"Rays".get_children()

var next: NextNode
var lastNode: NextNode
var sr: Sprite2D

var can_move: bool = true
var last_player_pos: Vector2
var is_chasing = false

var stun_timer = 0.0

func _process(_delta):
	for ray in rays:
		var c = (ray as RayCast2D).get_collider()
		if c != null and c.name == "Player":
			is_chasing = true
			last_player_pos = c.position
			return

	if is_chasing:
		is_chasing = false
		get_closest_node(last_player_pos)

func get_closest_node(pos: Vector2):
	var filter := func distanceComparaison(a: Node2D, b: Node2D):
		return pos.distance_to(a.position) < pos.distance_to(b.position)
	
	var targetNodes = get_tree().get_current_scene().get_node("AINodes").get_children()
	targetNodes.sort_custom(filter)
	next = targetNodes[0]

func _ready():
	sr = $"./Sprite2D"
	lastNode = null

	get_closest_node(position)

func _integrate_forces(state):
	queue_redraw()

	if !can_move || stun_timer > 0.0:
		stun_timer -= 0.0
		if stun_timer <= 0.0:
			get_closest_node(last_player_pos)
		return

	var target: Vector2
	var currSpeed = Speed
	if is_chasing:
		target = last_player_pos
		currSpeed *= 1.3
	else:
		target = next.position

	linear_velocity = (target - position).normalized() * currSpeed
	if !is_chasing && position.distance_to(next.position) < MinDistance:
		var tmp = lastNode
		lastNode = next
		next = next.getRandomNext(tmp)
	sr.flip_h = linear_velocity.x < 0

func get_hit():
	can_move = false
	linear_velocity = Vector2.ZERO
	gravity_scale = 1.0
	set_collision_mask_value(3, true)

func collect():
	if !can_move:
		self.queue_free()

func propulse(dir: Vector2):
	stun_timer = 1.0
	linear_velocity += dir

func _draw():
	if next != null:
		draw_line(position, last_player_pos if is_chasing else next.position, Color.RED, 3.0)
