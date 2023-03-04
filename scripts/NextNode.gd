@tool
extends Node2D

class_name NextNode

@export var Next: Array[String]

func indexToNode(i):
	return get_parent().get_node("AIMovNode" + Next[i])

func _draw():
	for i in range(0, Next.size()):
		draw_line(position, indexToNode(i).position, Color.GREEN, 3.0)
