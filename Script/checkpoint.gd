extends Area2D

@onready var respawn_point = get_node("RespawnPoint")
# Called when the node enters the scene tree for the first time.

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var respawn_point = get_node("/root/YourScene/RespawnPoint")  # Adjust path accordingly
	
		if respawn_point:
		# Update the position of RespawnPoint to the Area2D's position
			respawn_point.position = self.position
