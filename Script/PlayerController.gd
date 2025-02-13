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

var on_ladder: bool = false  # Default to false
var was_on_ladder_before_jump: bool = false  # Track ladder state before jumping

var last_safe_position = Vector2.ZERO  # Stores the last platform position

func _physics_process(delta: float) -> void:
	if is_on_floor():  # Update last safe position only when on a platform
		last_safe_position = position  
	
	# Handle gravity only if not on a ladder
	if not on_ladder:
		if not is_on_floor():
			velocity.y += gravity * delta
	else:
		# Reset vertical velocity when on a ladder
		velocity.y = 0
		if Input.is_action_pressed("up"):
			velocity.y = -walk_speed
		elif Input.is_action_pressed("down"):
			velocity.y = walk_speed

	# Handle jump
	if Input.is_action_just_pressed("jump"):
		if on_ladder: 
			# Only exit the ladder if the player is pressing the jump button while on the ladder
			velocity.y = JUMP_VELOCITY  # Apply jump force
			on_ladder = false  # Exit the ladder when jumping
		elif is_on_floor() or is_on_wall():
			velocity.y = JUMP_VELOCITY  # Normal jump
			was_on_ladder_before_jump = on_ladder  # Remember ladder state before jumping

	# Handle movement speed (walk & run)
	var speed
	if Input.is_action_pressed("run"):
		speed = run_speed
	else:
		speed = walk_speed

	# Get horizontal movement input
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)

	# Handle dashing
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
			velocity.y = 0  # Prevent falling during dash

	if dash_timer > 0:
		dash_timer -= delta

	# Animation logic
	if animated_sprite:
		if is_dashing:
			animated_sprite.play("dash")
		elif on_ladder:
			if velocity.y != 0:
				animated_sprite.play("climb")  # Play climb animation when moving up/down
			else:
				animated_sprite.pause()
		elif not is_on_floor() and not on_ladder:
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

# Ladder detection logic
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if not on_ladder and !was_on_ladder_before_jump:  # Only allow ladder entry if not jumping
		on_ladder = true
		print("Entered ladder: ", on_ladder)

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	on_ladder = false
	print("Exited ladder: ", on_ladder)

func respawn():
	# Set player position to the last safe position
	position = last_safe_position + Vector2(0, -5)  # Slight offset upwards

	# Apply a small downward force to avoid floating
	if not is_on_floor():  # Only adjust if not on the floor
		velocity.y = 10  # Small push down to make sure the player doesn't float
	
	velocity = Vector2.ZERO  # Reset velocity to prevent unintended movement
