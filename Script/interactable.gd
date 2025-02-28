extends Area2D

var player_inside = false
@onready var label = $Label
@export var layer_to_disable: int = 1  # Change this to the correct TileMap layer index
@onready var tilemap_layer = $"../TileMapLayers/Experimental Door"  # Adjust path to match your TileMap node
@onready var tilemap_collision = get_parent().get_node("StaticBody2D/Experimental")  # Adjust if needed
@onready var collision_shape = $CollisionShape2D  # Reference to Area2D's CollisionShape2D

func _ready():
	label.visible = false

func _process(delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		if GameManager.coins >= 10:
			GameManager.coins -= 10
			print("Door Opened!")
			tilemap_layer.visible = false  # Hide the door
			tilemap_collision.set_deferred("disabled", true)  # Disable collision

			# Make the Area2D inaccessible
			collision_shape.set_deferred("disabled", true)  # Disable Area2D collision
			label.visible = false  # Hide label
		else:
			print("Not Enough Coins!")

func _on_body_entered(body: CharacterBody2D) -> void:
	if not collision_shape.disabled:  # Only allow interaction if Area2D is active
		player_inside = true
		label.visible = true

func _on_body_exited(body: CharacterBody2D) -> void:
	player_inside = false
	label.visible = false
