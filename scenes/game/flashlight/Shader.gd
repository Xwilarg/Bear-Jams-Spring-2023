extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position() + (get_viewport().size / 2)
	mouse_pos = (mouse_pos / get_viewport().size)
	get_parent().get_node("GameHUD/ShaderRect").material.set_shader_param("mouse_position", mouse_pos)
