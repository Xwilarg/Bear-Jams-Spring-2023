extends Control


var level1 = preload("res://scenes/game/levels/level1.tscn")

func _ready():
	TranslationServer.set_locale("en") # Use to debug languages

func _on_button_pressed():
	get_tree().change_scene_to_packed(level1)
