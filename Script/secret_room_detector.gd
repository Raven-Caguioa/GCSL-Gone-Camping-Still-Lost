extends Area2D

@export var tilemap: TileMap  # Drag your TileMap here in the Inspector
@export var layer_name: String = "$TileMapLayers/SecretArea"  # Name of the hidden layer
@warning_ignore("unused_parameter")
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		toggle_secret_layer(false)  # Make the layer transparent & disable collision

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		toggle_secret_layer(true)  # Restore collision & visibility

func toggle_secret_layer(enable: bool) -> void:
	if not tilemap:
		return

	var layer_index = tilemap.get_layer_index(layer_name)
	if layer_index == -1:
		print("Layer not found:", layer_name)
		return

	# 1️⃣ Disable/Enable Collision
	tilemap.set_layer_collision_enabled(layer_index, enable)

	# 2️⃣ Make the layer transparent when disabled (secret area effect)
	var transparency = 1.0 if enable else 0.3  # 100% visible when enabled, 30% transparent when hidden
	tilemap.set_layer_modulate(layer_index, Color(1, 1, 1, transparency))
