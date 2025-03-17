extends Sprite2D

@export var deathParticle: PackedScene

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	Kill()

func Kill() -> void:
	if deathParticle:
		var _particle = deathParticle.instantiate()
		_particle.position = global_position
		_particle.rotation = global_rotation
		_particle.emitting = true
		get_tree().current_scene.add_child(_particle)

	queue_free()
