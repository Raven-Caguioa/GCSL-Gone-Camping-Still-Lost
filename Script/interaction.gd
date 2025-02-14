extends Area2D

var player_inside = false
@onready var label = $Label
@onready var dialog_box = get_node("DialogBox")  # Adjust path if needed

func _ready():
	label.visible = false

@warning_ignore("unused_parameter")
func _process(delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		dialog_box.show_dialog("This lies people who were alone on Valentines Day")

@warning_ignore("unused_parameter")
func _on_body_entered(body: CharacterBody2D) -> void:
	player_inside = true
	label.visible = true
	print(player_inside)

@warning_ignore("unused_parameter")
func _on_body_exited(body: CharacterBody2D) -> void:
	player_inside = false
	label.visible = false
	print(player_inside)
