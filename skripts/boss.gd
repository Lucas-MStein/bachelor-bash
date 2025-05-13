extends Node2D

var hit_count = 0
const SPEED = 250
var direction = -1

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = true
		
	position.x += direction * SPEED * delta

func take_hit():
	hit_count += 1
	animated_sprite.play("hurt")
	if hit_count >= 2:
		queue_free()  # Boss wird nach 2 Treffern entfernt
	else:
		print("Boss getroffen! Noch", 2 - hit_count, "Treffer nötig")
