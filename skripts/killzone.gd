extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Kollision mit:", body.name, " bei Spieler y:", body.position.y, " Killzone y:", global_position.y)
	
	# Prüfen, ob der kollidierende Körper der Spieler ist
	if body.is_in_group("player"):
		# Kollisionsformen holen
		var player_shape = body.get_node("playerShape") as CollisionShape2D
		var killzone_shape = get_node("killzoneShape") as CollisionShape2D
		
		if player_shape and killzone_shape:
			# Prüfe, ob der Spieler von oben kommt
			var is_from_above = body.position.y < global_position.y
			
			# Debugging: Kollisionsdetails
			print("Spieler y:", body.position.y, " Killzone y:", global_position.y)
			print("Von oben?", is_from_above)
			
			if is_from_above:
				var parent = get_parent()
				print("Parent ist:", parent.name, " in Gruppe:", parent.get_groups())
				if parent.is_in_group("floor"):
					GameManager.heart = 0
					GameManager.damage_heart()
				# Gegner oder Boss behandeln
				if parent.is_in_group("enemy") or parent.is_in_group("boss"):
					if parent.is_in_group("boss"):
						if parent.has_method("take_hit"):
							parent.take_hit()
							print("Boss nimmt Treffer")
						else:
							print("Boss hat keine take_hit Methode!")
					else:
						parent.queue_free()
						print("Gegner zerstört")
					
					# Spieler abprallen lassen
					if body.has_method("bounce"):
						body.bounce()
						print("Spieler bounced")
				else:
					print("Kollision mit nicht-Gegner:", parent.name)
			else:
				# Spieler wird bei seitlicher/unterer Kollision verletzt
				print("Seitliche/untere Kollision mit:", body.name)
				if GameManager.has_method("damage_heart"):
					GameManager.damage_heart()
					print("Spieler nimmt Schaden")
				else:
					print("GameManager.damage_heart nicht gefunden!")
		else:
			print("Fehler: CollisionShape2D nicht gefunden! Spieler:", player_shape, " Killzone:", killzone_shape)
	else:
		print("Kollision mit nicht-Spieler:", body.name)
