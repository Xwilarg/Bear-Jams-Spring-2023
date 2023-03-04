extends RigidBody2D

func _on_body_entered(body):
	if body.name == "Fish":
		(body as Fish).get_hit()
	self.queue_free()
