extends Area2D

var player_inside = false
@export var layer_to_disable: int = 1
@onready var tilemap_layer = $"../TileMapLayers/Experimental Door"
@onready var tilemap_collision = get_parent().get_node("Door/Experimental")
@onready var collision_shape = $CollisionShape2D
@onready var label = $Label
@onready var icon = $Sprite2D

func _ready():
	await get_tree().process_frame  # Wait one frame to ensure visibility updates
	label.visible = false
	icon.visible = false

func _process(delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		if GameManager.coins >= 10:
			GameManager.coins -= 10
			print("Door Opened!")
			tilemap_layer.visible = false
			tilemap_collision.set_deferred("disabled", true)
			collision_shape.set_deferred("disabled", true)
			label.visible = false
			icon.visible = false
		else:
			print("Not Enough Coins!")

func _on_body_entered(body) -> void:
	player_inside = true
	label.visible = true
	icon.visible = true

func _on_body_exited(body) -> void:
	player_inside = false
	icon.visible = false
	label.visible = false  # Fix this so it hides when leaving
