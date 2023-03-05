@tool
extends Node2D

class_name NodeManager

@export var refresh_draw = false : set = set_refresh

func set_refresh(_value):
	queue_redraw()
	refresh_draw = false

@export var LevelData: Array[String]

func get_my_nodes(index):
	var nodes: Array[String] = []
	for line in LevelData:
		var elems = line.split(',')
		if elems[0] == index:
			nodes.push_back(elems[1])
		elif elems[1] == index:
			nodes.push_back(elems[0])
	return nodes

func _draw():
	for line in LevelData:
		var elems = line.split(',')
		draw_line(get_node("AIMovNode" + elems[0]).position,
		get_node("AIMovNode" + elems[1]).position, Color.GREEN, 3.0)
