extends Node

@onready var player: AudioStreamPlayer = get_node("AudioStreamPlayer")
var music_enabled := true

func _ready():
	if player: 
		player.stream_paused = !music_enabled
		player.play()

func toggle_music():
	music_enabled = !music_enabled
	if player: 
		player.stream_paused = !music_enabled
