extends RigidBody2D

@export var Speed: float
@export var MinDistance: int

var next: NextNode
var sr: Sprite2D

func distanceComparaison(a: Node2D, b: Node2D):
	return position.distance_to(a.position) < position.distance_to(b.position)

func _ready():
	sr = $"./Sprite2D"

	var targetNodes = get_tree().get_current_scene().get_node("AINodes").get_children()
	targetNodes.sort_custom(distanceComparaison)
	next = targetNodes[0]

func _integrate_forces(state):
	linear_velocity = (next.position - position).normalized() * Speed
	if position.distance_to(next.position) < MinDistance:
		next = next.getRandomNext()
	sr.flip_h = linear_velocity.x < 0
