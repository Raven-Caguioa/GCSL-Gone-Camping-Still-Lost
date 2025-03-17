extends Area2D
@onready var dialog_box = get_node("DialogBox")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		dialog_box.show_dialog("This lies people who were alone on Valentines Day")
