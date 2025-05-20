extends Panel

@onready var sprite = $Heart

func _ready() -> void:
	pass 

func updateSprite(alive: bool):
	if alive:
		sprite.frame = 0
		print("Herz auf Frame 0 gesetzt")
	else:
		sprite.frame = 1
		print("Herz auf Frame 1 gesetzt")
