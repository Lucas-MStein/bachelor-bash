extends Node

@onready var player: AudioStreamPlayer = get_node("AudioStreamPlayer")
var music_enabled := true

func _ready():
	# Musik starten (nur wenn aktiviert)
	player.stream_paused = !music_enabled
	player.play()

func toggle_music():
	music_enabled = !music_enabled
	player.stream_paused = !music_enabled
