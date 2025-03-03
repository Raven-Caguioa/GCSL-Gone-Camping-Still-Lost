extends Control

@onready var world_1 = get_tree().current_scene 

func _on_resume_pressed() -> void:
	if world_1:
		world_1.pause()
	else:
		print("ERROR: World is null.")

func _on_quit_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
