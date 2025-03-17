extends Node2D

var coins = 10
var score = 0
var heart = 3
var is_paused = false  # Track if the game is paused

var hidden_scenes = ["MainMenu", "GameOverScreen", "world_1", "main_menu"]

func _process(delta: float) -> void:
	$"GUI/CoinValue".text = str(coins)
	$"GUI/ScoreValue".text = str(score)

func _ready():
	check_gui_visibility()
	#$"PauseMenuLayer".visible = false  # Ensure the menu starts hidden

# Toggle Pause Menu
func toggle_pause():
	is_paused = not is_paused  # Flip the pause state
	get_tree().paused = is_paused  # Pause or unpause the game
	#$"PauseMenuLayer".visible = is_paused  # Show or hide the menu

	# Optionally, disable input when paused
	#if is_paused:
		#$"PauseMenuLayer".set_process_input(true)
	#else:
		#$"PauseMenuLayer".set_process_input(false)

# Resume the game
func _on_resume_button_pressed():
	toggle_pause()

# Exit to main menu
func _on_exit_button_pressed():
	get_tree().paused = false  # Unpause before changing scenes
	get_tree().change_scene_to_file("res://MainMenu.tscn")

# Handle GUI visibility per scene
func check_gui_visibility():
	var current_scene = get_current_scene_name()
	var gui = $GUI

	if gui:
		var should_be_visible = not (current_scene in hidden_scenes)
		gui.visible = should_be_visible
		gui.set_process_input(should_be_visible)

# Get the current scene name properly
func get_current_scene_name() -> String:
	var scene_path = get_tree().current_scene.scene_file_path
	var scene_name = scene_path.get_file().get_basename()
	return scene_name

# Open pause menu when "Esc" is pressed
func _input(event):
	if event.is_action_pressed("cancel"):  # Default "Esc" key
		toggle_pause()

	if not $"GUI".visible:
		get_viewport().set_input_as_handled()
