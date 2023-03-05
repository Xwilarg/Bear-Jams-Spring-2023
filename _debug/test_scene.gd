extends Node2D
# testing stuff


@onready var player = %Player as Player
@onready var debug_hud = %DebugHud as DebugHud


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()


func _draw():
	pass
	#draw velocity
	#debug_hud.above_player.text = "velocity: " + str(player.velocity)
