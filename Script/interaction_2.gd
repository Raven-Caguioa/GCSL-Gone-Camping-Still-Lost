extends Area2D

var player_inside = false
@onready var label = $Label

func _ready():
	label.visible = false

@warning_ignore("unused_parameter")
func _process(delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		print("Hello Alam Mo Ba?...... Wala lng")

@warning_ignore("unused_parameter")
func _on_body_entered(body: CharacterBody2D) -> void:
	player_inside = true
	label.visible = true

@warning_ignore("unused_parameter")
func _on_body_exited(body: CharacterBody2D) -> void:
	player_inside = false
	label.visible = false
