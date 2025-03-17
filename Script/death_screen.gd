extends CanvasLayer

@onready var fade_rect = $ColorRect  
@onready var button = $Button  

func _ready():
	visible = false
	button.disabled = true  
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE  # Ensure clicks go through

	set_process_input(true)  # Allow input processing

	# Ensure the button's pressed signal is connected
	if not button.is_connected("pressed", _on_button_pressed):
		button.pressed.connect(_on_button_pressed)

func show_screen():
	visible = true  
	button.disabled = false  
	button.set_focus_mode(Control.FOCUS_ALL)  # Ensure it's interactable

func hide_screen():
	visible = false  
	button.disabled = true  

func _on_button_pressed() -> void:
	GameManager.heart += 3
	print("hello")  # This should now work!
	hide_screen()
