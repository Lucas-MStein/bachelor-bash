extends Node

@onready var player: AudioStreamPlayer = $AudioStreamPlayer
var music_enabled: bool = true
var is_active: bool = true

func _ready():
    if music_enabled and player.playing == false:
        player.play()

func toggle_music():
    music_enabled = !music_enabled
    if player: 
        if music_enabled:
            player.play()
        else:
            player.stop()
