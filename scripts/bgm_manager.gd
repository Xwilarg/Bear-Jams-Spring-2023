extends Node

@export var bgm1: AudioStreamPlayer
@export var bgm2: AudioStreamPlayer
@export var bgm3: AudioStreamPlayer

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
		bgm1.volume_db = 50 - (y - 300.0) * 50.0 / 400.0 - 50.0
		bgm2.volume_db = (y - 300.0) * 50.0 / 400.0 - 50.0
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
		bgm2.volume_db = 50 - (y - 1800.0) * 50.0 / 400.0 - 50.0
		bgm3.volume_db = (y - 1800.0) * 50.0 / 400.0 - 50.0
		pass
	else:
		bgm1.stop()
		bgm2.stop()
		if !bgm3.playing:
			bgm3.play()
			bgm3.volume_db = 0
