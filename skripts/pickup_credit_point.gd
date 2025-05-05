extends Area2D

@onready var game_manager: Node2D = $"../GameManager"

func _on_body_entered(body: Node2D) -> void:
	print("+1 coin")
	game_manager.add_coin()
	queue_free()
