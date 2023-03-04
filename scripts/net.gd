extends RigidBody2D

func _on_body_entered(body):
	if body.name == "Fish":
		body.queue_free()
		(body as Fish).get_hit()
	self.queue_free()
