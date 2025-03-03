extends Control

func _ready():
	Engine.time_scale = 1
	get_tree().paused = false

func _on_play_pressed() -> void:
	Engine.time_scale = 1 
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Level Scenes/world_1.tscn")


func _on_controls_pressed() -> void:
	pass # Replace with function body.
	
	
func _on_quit_pressed() -> void:
	get_tree().quit()
