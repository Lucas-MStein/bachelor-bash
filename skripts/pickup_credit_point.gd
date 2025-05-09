extends Area2D

@onready var coin_sound = $AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
	print("+1 coin")
	GameManager.add_coin()
	var player = AudioStreamPlayer.new()
	player.stream = preload("res://assets/music/pickup_Creditpoint.mp3")
	player.autoplay = true
	player.finished.connect(player.queue_free) 
	get_tree().root.add_child(player)
	queue_free()
	
