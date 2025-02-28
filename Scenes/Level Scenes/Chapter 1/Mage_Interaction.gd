extends Area2D

var player_inside = false
@onready var label = $Label
@onready var dialog_layer = get_node("DialogBox")

func _ready():
	label.visible = false

func _process(delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		dialog_layer.show_dialog([
			"Hello Alam Mo Ba?",
			"Wala lang...",
			"Pero, gusto mo bang malaman?",
			"Ahh, wala din pala ako sasabihin. Haha!"
		])

func _on_body_entered(body: CharacterBody2D) -> void:
	player_inside = true
	label.visible = true

func _on_body_exited(body: CharacterBody2D) -> void:
	player_inside = false
	label.visible = false
