extends CanvasLayer

@onready var dialog_text = $Control/Panel/Label
@onready var dialog_panel = $Control/Panel

var is_active = false

func _ready():
	dialog_panel.visible = false  # Hide dialog by default

func show_dialog(text: String):
	dialog_text.text = text
	dialog_panel.visible = true
	is_active = true

func hide_dialog():
	dialog_panel.visible = false
	is_active = false

func _input(event):
	if is_active and event.is_action_pressed("accept"):  # Close on Enter/Space
		hide_dialog()
