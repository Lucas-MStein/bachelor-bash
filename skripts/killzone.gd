extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Kollision mit:", body.name)
	GameManager.damage_heart()
	print("You died")
