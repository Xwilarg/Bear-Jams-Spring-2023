extends Node

class_name BGM_Manager

@export var bgm1: AudioStreamPlayer
@export var bgm2: AudioStreamPlayer
@export var bgm3: AudioStreamPlayer

const MIN: float = 25.0

func set_y(y):
	if y < 300:
		if !bgm1.playing:
			bgm1.play()
			bgm1.volume_db = 0
		bgm2.stop()
		bgm3.stop()
	elif y < 700:
		if !bgm1.playing:
			bgm1.play()
		if !bgm2.playing:
			bgm2.play()
		bgm1.volume_db = MIN - (y - 300.0) * MIN / 400.0 - MIN
		bgm2.volume_db = (y - 300.0) * MIN / 400.0 - MIN
		bgm3.stop()
	elif y < 1800:
		bgm1.stop()
		if !bgm2.playing:
			bgm2.play()
			bgm2.volume_db = 0
		bgm3.stop()
	elif y < 2200:
		bgm1.stop()
		if !bgm2.playing:
			bgm2.play()
		if !bgm3.playing:
			bgm3.play()
		bgm2.volume_db = MIN - (y - 1800.0) * MIN / 400.0 - MIN
		bgm3.volume_db = (y - 1800.0) * MIN / 400.0 - MIN
		pass
	else:
		bgm1.stop()
		bgm2.stop()
		if !bgm3.playing:
			bgm3.play()
			bgm3.volume_db = 0
