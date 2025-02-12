extends CharacterBody2D

@export var walk_speed = 150.0
@export var run_speed = 250.0
@export_range(0, 1) var deceleration = 0.1
@export_range(0, 1) var acceleration = 0.1

@export var jump_force = -400.0
@export_range(0, 1) var deceleration_on_jump_release = 0.5

const JUMP_VELOCITY = -400.0

@export var dash_speed = 500.0
@export var dash_max_distance = 100.00
@export var dash_curve: Curve
@export var dash_cooldown = 1.0

var is_dashing = false
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0

@onready var animated_sprite = $AnimatedSprite2D

@export var gravity = 980.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_wall()):
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= deceleration_on_jump_release
		
	var speed
	if Input.is_action_pressed("run"):
		speed = run_speed
	else:
		speed = walk_speed

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)
		
	if Input.is_action_just_pressed("dash") and direction and not is_dashing and dash_timer <= 0:
		is_dashing = true
		dash_start_position = position.x
		dash_direction = direction
		dash_timer = dash_cooldown
		
	if is_dashing:
		var current_distance = abs(position.x - dash_start_position)
		if current_distance >= dash_max_distance or is_on_wall():
			is_dashing = false
		else:
			if dash_curve:
				velocity.x = dash_direction * dash_speed * dash_curve.sample(current_distance / dash_max_distance)
			else:
				velocity.x = dash_direction * dash_speed
			velocity.y = 0
	
	if dash_timer > 0:
		dash_timer -= delta

	# Animation logic
	if animated_sprite:
		if is_dashing:
			animated_sprite.play("dash")
		elif not is_on_floor():
			animated_sprite.play("jump")
		elif Input.is_action_pressed("run") and velocity.x != 0:
			animated_sprite.play("run")
		elif velocity.x != 0:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")

		# Flip sprite based on direction
		if velocity.x > 0:
			animated_sprite.flip_h = false
		elif velocity.x < 0:
			animated_sprite.flip_h = true

	move_and_slide()
