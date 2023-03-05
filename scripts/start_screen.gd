extends Control

@export var credits: Panel
var level1 = preload("res://scenes/game/levels/level1.tscn")

func _ready():
	TranslationServer.set_locale("en") # Use to debug languages

func _on_button_pressed():
	get_tree().change_scene_to_packed(level1)


func _on_credits_pressed():
	credits.visible = true


func _on_credits_x_pressed():
	credits.visible = false
