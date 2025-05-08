extends Area2D

@onready var coin_sound = $AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
    print("+1 coin")
    GameManager.add_coin()
    coin_sound.play()
    await coin_sound.finished
    queue_free()
    
