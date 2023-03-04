@tool
extends Node2D

class_name NextNode

@export var Next: Array[String] # Thanks Godot https://github.com/godotengine/godot/issues/62916

@export var refresh_draw = false : set = set_refresh

func set_refresh(_value):
	queue_redraw()
	refresh_draw = false

# Get a node given its index
func indexToNode(i):
	return get_parent().get_node("AIMovNode" + Next[i])

# Return a random next node
func getRandomNext(exclude: NextNode):
	var excludeName = ""
	if exclude != null:
		excludeName = exclude.name.right(name.length() - 9)
	
	if Next.size() == 1:
		return indexToNode(0)
	
	var indexArray = []
	for i in range(0, Next.size()):
		if Next[i] != excludeName:
			indexArray.push_back(i)
	return indexToNode(indexArray[(get_tree().root.get_node("Rng") as RNG).random(indexArray.size())])

func _ready():
	# For each next node, we add ourself to it
	var me = name.right(name.length() - 9)
	for i in range(0, Next.size()):
		var node = (indexToNode(i) as NextNode)
		if !node.Next.has(me):
			node.Next.push_back(me)
		

func _draw():
	for i in range(0, Next.size()):
		draw_line(to_local(position), to_local(indexToNode(i).position), Color.GREEN, 3.0)
