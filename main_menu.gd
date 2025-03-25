extends Control

func _ready():
	# Find all buttons inside containers
	for button in find_children("*", "Button", true):
		button.pressed.connect(_on_button_pressed.bind(button))

func _on_button_pressed(button: Button):
	match button.name:
		"Play":
			print("Play Pressed")
			get_tree().change_scene_to_file("res://Scenes/Level Scenes/Chapter 1/Chapter1.tscn")
		"Options":
			print("Options Pressed")
		"Exit":
			print("Exit Pressed")
			get_tree().quit()

func _on_test_pressed() -> void:
	print("test")
