extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.position.y < global_position.y:
			get_parent().queue_free()  # Entfernt den Gegner
			if body.has_method("bounce"):
				body.bounce()
	else:
		print("Kollision mit:", body.name)
		GameManager.damage_heart()
		print("You died")
