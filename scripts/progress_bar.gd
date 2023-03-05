class_name ProgressBarContainer
extends MarginContainer
# displays value as ring


@export var label_text: String

var value: float
var player: Player

@onready var progress_bar := %ProgressBar as TextureProgressBar
@onready var label := %Label as Label
@onready var icon := %Icon as Sprite2D


func _ready():
	player = get_tree().get_first_node_in_group("player")
	label.text = label_text


func _process(_delta):
	# pressure = depth?
	value = player.health
	if value > progress_bar.max_value:
		value = progress_bar.max_value
	
	if value != progress_bar.value:
		queue_redraw()


func _draw():
	progress_bar.value = value
