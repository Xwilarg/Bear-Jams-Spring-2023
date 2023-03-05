class_name ProgressRing
extends MarginContainer
# displays value as ring


@export var label_text: String
@export var value: float
@export var max_value: float = 100.0

var player: Player
	
@onready var label := %Label as Label
@onready var progress_bar := %ProgressBar as TextureProgressBar
@onready var value_text := %ValueText as Label


func _ready():
	player = get_tree().get_first_node_in_group("player")
	label.text = label_text
	progress_bar.max_value = max_value
	value_text.text = str(value)


func _process(_delta):
	value = ceilf(player.pressure)
	if value > max_value:
		value = max_value
	
	if value != progress_bar.value:
		queue_redraw()


func _draw():
	value_text.text = str(value)
	progress_bar.value = value
