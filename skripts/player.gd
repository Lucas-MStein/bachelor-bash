extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var cShape = $playerShape

@onready var jumpAudio: AudioStreamPlayer = $jumpAudio
@onready var slideAudio: AudioStreamPlayer = $slideAudio
@onready var downAudio: AudioStreamPlayer = $downAudio
@onready var bounceAudio: AudioStreamPlayer = $bounceAudio

const SPEED = 500.0
const JUMP_VELOCITY = -600.0

const MIN_X = 460
const MAX_X = 45000

var double_jump_used = false;
var is_sliding = false;
var last_direction = 0.0
var has_played_down_audio = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var standing_cShape = preload("res://ressources/player_idel_CollisionShape.tres")
var sliding_cShape = preload("res://ressources/player_Slide_CollisionShape.tres")

func _ready() -> void:
	add_to_group("player")
	animated_sprite.frame_changed.connect(_on_animated_sprite_frame_changed)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump"):
		jumpAudio.play()
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif not double_jump_used:
			velocity.y = JUMP_VELOCITY
			double_jump_used = true
	
	if is_on_floor():
		double_jump_used = false
	
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	if is_sliding and direction != 0 and last_direction != direction and not slideAudio.playing:
		slideAudio.play()
	
	last_direction = direction
	
	if Input.is_action_just_pressed("down"):
		slide()
	elif Input.is_action_just_released("down"):
		stand()
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	position.x = clamp(position.x, MIN_X, MAX_X)
	
	update_animation(direction)
	
	switch_direction(direction)
	

# Play animation
func update_animation(direction):
	if is_on_floor():
		if direction == 0:
			if is_sliding:
				animated_sprite.play("down")
			else:
				animated_sprite.play("idle")
		else:
			if is_sliding:
				animated_sprite.play("slide")
			else:
				animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

# Flip the Sprite
func switch_direction(direction):
	if direction > 0:
		animated_sprite.flip_h =false
	elif direction < 0:
		animated_sprite.flip_h = true

func _on_animated_sprite_frame_changed():
	if animated_sprite.animation == "down" and animated_sprite.frame == 0 and not has_played_down_audio:
		if not downAudio.playing:
			downAudio.play()
			has_played_down_audio = true  # Verhindert erneutes Abspielen
		
func slide():
	if  is_sliding:
		return
	is_sliding = true
	cShape.shape = sliding_cShape
	cShape.position.y = -88
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		slideAudio.play()
	else:
		has_played_down_audio = false

	
func stand():
	if  is_sliding == false:
		return
	is_sliding = false
	cShape.shape = standing_cShape
	cShape.position.y = -112
	
func bounce():
	bounceAudio.play()
	if velocity.y > -400:
		velocity.y = -400
