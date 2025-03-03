extends Button



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level Scenes/world_1.tscn")


func _on_settings_pressed() -> void:
	pass
	
func _on_quit_pressed() -> void:
	get_tree().quit()
