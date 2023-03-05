extends Control


@export var swim_frequency: float = 2.0
@export var swim_amplitude: float = 50.0

var level1 = preload("res://scenes/game/levels/level2.tscn")

var _time: float = 0

@onready var credits_button := %CreditsButton as Button
@onready var credits := %Credits as Panel


func _physics_process(delta):
	# move right
	credits_button.position.x += 1
	
	if credits_button.position.x > 1000:
		credits_button.position.x = -300
	
	# swim
	_time += delta
	credits_button.position.y += cos(_time * swim_frequency) * swim_amplitude * delta


func _on_button_pressed():
	get_tree().change_scene_to_packed(level1)


func _on_credits_pressed():
	credits.visible = true


func _on_credits_x_pressed():
	credits.visible = false

func _on_en_pressed():
	TranslationServer.set_locale("en")
	
func _on_fr_pressed():
	TranslationServer.set_locale("fr")
	
func _on_tr_pressed():
	TranslationServer.set_locale("tr")

func _on_de_pressed():
	TranslationServer.set_locale("de")
