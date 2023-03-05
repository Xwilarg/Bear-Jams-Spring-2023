class_name Hud
extends CanvasLayer


@onready var health := %Health as ProgressBarContainer


func take_damage(amount: int):
	health.value -= float(amount)
