extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):  # Use CharacterBody2D instead of Player class
		var parent = get_parent()
		if parent:
			parent.modulate.a = 0.1  # Reduce transparency when player enters


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group('Player'):
		var parent = get_parent()
		if parent:
			parent.modulate.a = 1  # Restore visibility when player exits
