class_name ProgressRing
extends MarginContainer
# displays value as ring


@export var label_text: String

var value: float
var player: Player

@onready var progress_bar := %ProgressBar as TextureProgressBar
@onready var value_text := %ValueText as Label


func _ready():
	player = get_tree().get_first_node_in_group("player")
	value_text.text = str(value)


func _process(_delta):
	value = ceilf(player.pressure)
	if value > progress_bar.max_value:
		value = progress_bar.max_value
	
	if value != progress_bar.value:
		queue_redraw()


func _draw():
	value_text.text = str(value)
	progress_bar.value = value
