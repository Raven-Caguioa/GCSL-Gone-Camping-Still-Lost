extends Control

@onready var world_1 = $"../../" 

func _on_resume_pressed():
	get_tree().paused = false
	self.hide()

func _on_quit_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
