extends Node

@onready var player: AudioStreamPlayer = $AudioStreamPlayer
var is_active: bool = true

func _ready():
	if not player.stream:
		print("ERROR: Kein AudioStream im AudioStreamPlayer zugewiesen!")
	Global.music_enabled_changed.connect(_on_music_enabled_changed)
	Ui.music_toggle_pressed.connect(_on_music_toggle_pressed)
	update_music_state()

func _on_music_toggle_pressed():
	print("MusicPlayer: Toggle pressed, Frame: ", Engine.get_frames_drawn())
	Global.music_enabled = !Global.music_enabled

func update_music_state():
	if player:
		if Global.music_enabled and is_active:
			player.stream_paused = false
			if not player.playing:
				player.play()
		else:
			player.stream_paused = true
		print("MusicPlayer: playing=", player.playing, " paused=", player.stream_paused)

func _on_music_enabled_changed(new_state: bool):
	update_music_state()
	print("MusicPlayer: Music enabled changed to ", new_state)
