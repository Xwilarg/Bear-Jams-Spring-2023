extends Area2D


func _on_player_entered(player: Player):
	if player == null:
		return
	
	%SoundPlayer.play()
