extends Node2D

@onready var music_toggle = get_node("/root/Ui/MusicToggleButton")
@onready var audio_player = $AudioStreamPlayer         

var current_level: int = 1

func _ready() -> void:
	Global.set_Level(current_level)
	Global.load_game()
	print("Level 1 wurde geladen!")
	
	MusicPlayer.is_active = false
	MusicPlayer.player.stop()
	
	GameManager.is_active = true
	GameManager.update_ui_visibility()
	
	music_toggle.focus_mode = Control.FOCUS_NONE
	music_toggle.button_pressed = !Global.music_enabled
	Global.music_enabled_changed.connect(_on_music_enabled_changed)
	Ui.music_toggle_pressed.connect(_on_music_toggle_pressed)
	
	if Global.music_enabled and not audio_player.playing:
		audio_player.play()
	else:
		audio_player.stream_paused = true

func _on_music_toggle_pressed():
	print("Level: Music toggle pressed, Frame: ", Engine.get_frames_drawn())

func _on_music_enabled_changed(new_state: bool):
	music_toggle.button_pressed = !new_state
	if audio_player:
		if new_state:
			audio_player.stream_paused = false
			if not audio_player.playing:
				audio_player.play()
		else:
			audio_player.stream_paused = true
	print("Level: Music enabled changed to ", new_state)
