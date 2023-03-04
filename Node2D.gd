extends Node2D

@onready var ShaderRect = get_parent().get_node("GameHUD/ShaderRect")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var globalposx = get_global_mouse_position().x
	var globalposy = get_global_mouse_position().y
	var viewposx = get_viewport().size.x
	var viewposy = get_viewport().size.y
	
	var mouse_pos : Vector2i 
	mouse_pos.x = globalposx + viewposx/2
	mouse_pos.y = globalposy + viewposy/2
	
	mouse_pos.x = (mouse_pos.x / get_viewport().size.x)
	mouse_pos.y = (mouse_pos.y / get_viewport().size.y)
	ShaderRect.material.set_shader_parameter("mouse_position", mouse_pos)
