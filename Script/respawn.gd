extends Area2D

func _on_body_entered(body) -> void:
	if body is CharacterBody2D and body.is_in_group("Player"):
		if body.has_method("respawn"):  
			body.die()  # Move the player back to their last safe position
