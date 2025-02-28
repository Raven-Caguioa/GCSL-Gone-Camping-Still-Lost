extends Area2D

@onready var camera_2d = $"../Player/Camera2D"
@onready var shape = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var shape_size = shape.shape.get_rect().size * shape.global_scale  # Apply global scale correctly
		var target_limits = {
			"limit_left": position.x,
			"limit_top": position.y - shape_size.y,
			"limit_right": position.x + shape_size.x,
			"limit_bottom": position.y
		}

		animate_camera(target_limits)

func animate_camera(target_limits: Dictionary):
	var tween = create_tween()  # Use create_tween() instead of Tween.new()
	tween.set_trans(Tween.TRANS_QUAD)  # Smooth ease-in-out effect
	tween.set_ease(Tween.EASE_OUT)  # Smooth easing

	# Interpolate camera limits smoothly
	tween.tween_property(camera_2d, "limit_left", target_limits["limit_left"], 0.2)
	tween.tween_property(camera_2d, "limit_top", target_limits["limit_top"], 0.2)
	tween.tween_property(camera_2d, "limit_right", target_limits["limit_right"], 0.2)
	tween.tween_property(camera_2d, "limit_bottom", target_limits["limit_bottom"], 0.2)
