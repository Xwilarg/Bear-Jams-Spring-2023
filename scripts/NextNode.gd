@tool
extends Node2D

class_name NextNode

@export var Next: Array[String]

func indexToNode(i):
	return get_parent().get_node("AIMovNode" + Next[i])

func getRandomNext():
	return indexToNode((get_tree().root.get_child(0).get_node("RNG") as RNG).random(Next.size()))

func _ready():
	for i in range(0, Next.size()):
		(indexToNode(i) as NextNode).Next.push_back(self)
		

func _draw():
	for i in range(0, Next.size()):
		draw_line(position, indexToNode(i).position, Color.GREEN, 3.0)
