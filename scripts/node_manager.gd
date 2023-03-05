extends Node2D

class_name NodeManager

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
