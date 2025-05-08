extends Panel

@onready var sprite = $Heart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func updateSprite(alive: bool):
	if alive:
		sprite.frame = 0
		print("Herz auf Frame 0 gesetzt")
	else:
		sprite.frame = 1
		print("Herz auf Frame 1 gesetzt")
