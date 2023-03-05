class_name ProgressBarContainer
extends MarginContainer
# displays value as ring


@export var label_text: String
@export var image: Texture
@export var value: float
@export var max_value: float = 100.0

var player: Player

@onready var progress_bar := %ProgressBar as TextureProgressBar
@onready var label := %Label as Label
@onready var icon := %Icon as Sprite2D


func _ready():
	player = get_tree().get_first_node_in_group("player")
	label.text = label_text
	icon.texture = image
	progress_bar.max_value = max_value



	
func _process(_delta):
	# pressure = depth?
	value = player.health
	if value > max_value:
		value = max_value
	
	if value != progress_bar.value:
		queue_redraw()


func _draw():
	progress_bar.value = value
