extends CanvasLayer

@onready var dialog_text = $Control/Panel/Label
@onready var dialog_panel = $Control/Panel

var is_active = false
var dialog_lines = []  # List to store dialogue lines
var current_line = 0

func _ready():
	dialog_panel.visible = false
	set_process_unhandled_input(false)

# Function to start the dialogue
func show_dialog(lines: Array):
	dialog_lines = lines
	current_line = 0
	dialog_panel.visible = true
	is_active = true
	display_line()

# Function to update the text with the current line
func display_line():
	if current_line < dialog_lines.size():
		dialog_text.text = dialog_lines[current_line]
	else:
		hide_dialog()  # Hide when all lines are shown

# Function to hide the dialog box
func hide_dialog():
	dialog_panel.visible = false
	is_active = false

# Handle input for progressing through dialogue
func _input(event):
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
