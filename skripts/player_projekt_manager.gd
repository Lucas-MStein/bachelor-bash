extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0

var double_jump_used = false;

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif not double_jump_used:
			velocity.y = JUMP_VELOCITY
			double_jump_used = true
	
	if is_on_floor():
		double_jump_used = false
	
	
	# Get the input direction and handle the movement/deceleration.
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h =false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# To do - Play animation down
	
	# Play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
