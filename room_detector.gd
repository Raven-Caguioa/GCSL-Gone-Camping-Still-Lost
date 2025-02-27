extends Area2D

@onready var camera_2d = $"../Player/Camera2D"
@onready var shape = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var shape_size = shape.shape.get_rect().size  # Updated for Godot 4
		var scale_factor = shape.scale

		camera_2d.limit_left = position.x
		camera_2d.limit_top = position.y - (shape_size.y * scale_factor.y)
		camera_2d.limit_right = position.x + (shape_size.x * scale_factor.x)
		camera_2d.limit_bottom = position.y
