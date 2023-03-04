extends Node

class_name RNG

var rng = RandomNumberGenerator.new()

func random(max: int):
	return rng.randf_range(0, max)
