extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("respawn"):  
		body.respawn()  # Move the player back to their last safe position
