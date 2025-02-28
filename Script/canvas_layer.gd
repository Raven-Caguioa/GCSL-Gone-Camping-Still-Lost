extends CanvasLayer

@onready var dialog_text = $Control/Panel/Label
@onready var dialog_panel = $Control/Panel

var is_active = false

func _ready():
	dialog_panel.visible = false
	set_process_unhandled_input(false)

func show_dialog(text: String):
	dialog_text.text = text
	dialog_panel.visible = true
	is_active = true

func hide_dialog():
	dialog_panel.visible = false
	is_active = false

func _input(event):
<<<<<<< HEAD
	if is_active and event.is_action_pressed("accept"):
<<<<<<< Updated upstream
<<<<<<< Updated upstream
		current_line += 1
		display_line()
=======
=======
>>>>>>> Stashed changes
		hide_dialog()
		
		
func _unhandled_input(event):
	get_viewport().set_input_as_handled()
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
=======
	if is_active and event.is_action_pressed("accept"):  # Close on Enter/Space
		hide_dialog()
>>>>>>> parent of 9cf4344 (...)
