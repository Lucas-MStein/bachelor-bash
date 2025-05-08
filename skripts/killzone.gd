extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("player"):
        # Wenn der Spieler von oben auf die Killzone springt
        if body.position.y < global_position.y:
            get_parent().queue_free()  # Entfernt den Gegner
            if body.has_method("bounce"):
                body.bounce()
        else:
            print("You died")
            timer.start()

func _on_timer_timeout() -> void:
    get_tree().reload_current_scene()
