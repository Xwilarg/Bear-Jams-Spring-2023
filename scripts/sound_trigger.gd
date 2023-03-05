extends Area2D


func _on_player_entered(player: Player):
	if player == null:
		return
	
	%SoundPlayer.play()
	self.disconnect("body_entered", _on_player_entered)
