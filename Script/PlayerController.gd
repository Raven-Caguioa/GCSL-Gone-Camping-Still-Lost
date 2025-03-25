extends CharacterBody2D

@export var walk_speed = 250.0
@export var run_speed = 250.0
@export var acceleration = 0.1
@export var deceleration = 0.1

@export var jump_force = -500.0
@export var wall_jump_force = Vector2(250, -500)  # Push away from the wall
@export var wall_jump_boost = 10.0  # Extra boost for easier wall jumps
@export var wall_jump_cooldown = 0.2  # Delay between wall jumps

@export var gravity = 980.0
@export var coyote_time = 0.15  # Time after leaving ground when you can still jump

@export var dash_speed = 500.0
@export var dash_max_distance = 100.0
@export var diagonal_dash_multiplier = 1.2  # Increase distance for diagonal dashes
@export var dash_curve: Curve
@export var dash_cooldown = 1.0

@export var wall_coyote_time = 0.15  # Time to allow wall jump after leaving
var wall_touch_timer = 0.0  # Timer to track wall contact

var is_dashing = false
var dash_start_position = Vector2.ZERO
var dash_direction = Vector2.ZERO
var dash_timer = 0
var dash_air_count = 1  # Allow one air dash

var wall_jump_timer = 0.0  
var coyote_timer = 0.0  
var can_wall_jump = true  
var last_wall_normal = Vector2.ZERO

var on_ladder: bool = false  
var was_on_ladder_before_jump: bool = false

var current_position = Vector2.ZERO
var respawn_position: Vector2

@onready var death_screen = get_node("/root/Chapter1/DeathScreen")
@onready var transition = get_node("/root/Chapter1/transition_screen")
@onready var animated_sprite = $AnimatedSprite2D
@onready var explosion = $explosion  # Reference to your explosion effect
@export var respawn_delay = 1.0  # Time before respawning

func _physics_process(delta: float) -> void:
	# Coyote time logic
	if is_on_floor():
		last_wall_normal = Vector2.ZERO
		wall_touch_timer = wall_coyote_time  # Reset timer when touching wall
		coyote_timer = coyote_time  
		can_wall_jump = true  
		dash_air_count = 1  # Reset dash when landing
	else:
		coyote_timer -= delta 
		wall_touch_timer -= delta 

	if wall_jump_timer > 0:
		wall_jump_timer -= delta  
	else:
		can_wall_jump = true  

	# Gravity & Ladder Handling
	if not on_ladder:
		if not is_on_floor() and not is_dashing:
			velocity.y += gravity * delta
	else:
		velocity.y = 0
		if Input.is_action_pressed("up"):
			velocity.y = -walk_speed
		elif Input.is_action_pressed("down"):
			velocity.y = walk_speed

	# Jump logic
	if Input.is_action_just_pressed("jump"):
		if on_ladder:  
			velocity.y = jump_force
			on_ladder = false  
		elif is_on_floor() or coyote_timer > 0:  
			velocity.y = jump_force
			coyote_timer = 0
		elif is_on_wall() or wall_touch_timer > 0:  
			wall_jump()  
			wall_touch_timer = 0  

	# Handle movement
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if direction.length() > 0:
		direction = direction.normalized()
	var speed = run_speed if Input.is_action_pressed("run") else walk_speed

	if direction.x != 0:
		velocity.x = move_toward(velocity.x, direction.x * speed, speed)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)

	# Handle dashing
	if Input.is_action_just_pressed("dash") and direction and not is_dashing and dash_timer <= 0:
		if is_on_floor() or dash_air_count > 0:  # Allow dash if on floor or has air dash left
			is_dashing = true
			dash_start_position = position
			dash_direction = direction
			dash_timer = dash_cooldown

			var dash_distance = dash_max_distance
			if abs(dash_direction.x) > 0 and abs(dash_direction.y) > 0:
				dash_distance *= diagonal_dash_multiplier

			if not is_on_floor():
				dash_air_count -= 1  # Consume air dash

	if is_dashing:
		var current_distance = (position - dash_start_position).length()
		if current_distance >= dash_max_distance or is_on_wall() or is_on_ceiling():
			is_dashing = false
		else:
			if dash_curve:
				velocity = dash_direction * dash_speed * dash_curve.sample(current_distance / dash_max_distance)
			else:
				velocity = dash_direction * dash_speed
		# Apply gravity similar to jumping
		velocity.y += gravity * delta

	if dash_timer > 0:
		dash_timer -= delta

	# Handle animations
	if animated_sprite:
		if is_dashing:
			animated_sprite.play("dash")
		elif on_ladder:
			if velocity.y != 0:
				animated_sprite.play("climb")  
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

	# Ensure the sprite always faces the correct direction
	if direction.x != 0:
		animated_sprite.flip_h = direction.x < 0

	move_and_slide()

# Wall Jump Logic with Boost
func wall_jump():
	is_dashing = false  # Reset dashing on wall jump
	var current_wall_normal = get_wall_normal()  # Get current wall direction

	# Only wall jump if switching walls
	if current_wall_normal != last_wall_normal:
		can_wall_jump = false
		wall_jump_timer = wall_jump_cooldown

		var wall_direction = -current_wall_normal.x  # Jump away from the wall
		velocity = Vector2(wall_jump_force.x * wall_direction, wall_jump_force.y - wall_jump_boost)

		last_wall_normal = current_wall_normal  # Store this wall as the last one

func die():
	GameManager.death += 1
	velocity = Vector2.ZERO  
	set_physics_process(false)  
	set_process(false)  

	animated_sprite.visible = false  
	explosion.restart()  
	explosion.emitting = true  

	# Get the transition and play animation
	#transition.transition_in()  # Play the swipe-in animation

	await get_tree().create_timer(respawn_delay).timeout  
	respawn()

# Ladder detection logic
@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body) -> void:
	if not on_ladder and !was_on_ladder_before_jump:  
		on_ladder = true
		print("Entered ladder: ", on_ladder)
		
func _on_checkpoint_body_entered(body) -> void:
	if body is CharacterBody2D and body.is_in_group("Player"):
		print("hhelo")
		respawn_position = body.global_position  # Get the player's position
		print("Checkpoint updated to: ", respawn_position)

func _on_area_2d_body_exited(body) -> void:
	on_ladder = false
	print("Exited ladder: ", on_ladder)

# Respawn logic
func respawn():
	position = respawn_position  # Move player to the respawn point
	velocity = Vector2.ZERO  # Reset velocity

	set_physics_process(true)  # Re-enable physics
	set_process(true)  # Resume regular processing (optional)
	
	animated_sprite.visible = true  # Show player again

	if not is_on_floor():
		velocity.y = 10  

	velocity = Vector2.ZERO
