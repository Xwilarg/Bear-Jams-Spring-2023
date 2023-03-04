class_name RNG
extends Node


var _rng = RandomNumberGenerator.new()


func _init():
	_rng.randomize()
	

func random(max: int) -> float:
	return _rng.randf_range(0, max)
