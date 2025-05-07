extends HBoxContainer

@onready var heart_icon = preload("res://scenes/heart.tscn")

func setMaxHearts(max: int):
	print("setMaxHearts aufgerufen mit max:", max)
	for child in get_children():
		remove_child(child)
		child.queue_free()
	for i in range(max):
		var heart = heart_icon.instantiate()
		add_child(heart)
		print("Herz", i, "hinzugefügt:", heart)
		
func updateHearts(heart: int):
	var hearts = get_children()
	print("updateHearts aufgerufen mit heart:", heart)
	print("Anzahl der Herzen im Container:", hearts.size())
	
	for i in range(hearts.size()):
		if i < heart:
			hearts[i].updateSprite(true)
			print("Herz", i, "auf alive gesetzt")
		else:
			hearts[i].updateSprite(false)
			print("Herz", i, "auf dead gesetzt")
