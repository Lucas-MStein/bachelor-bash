extends Node2D

@onready var music_toggle = $UI_Button/MusicToggleButton
@onready var audio_player = $AudioStreamPlayer         
var music_enabled := true

var current_level: int = 5

func _ready() -> void:	
	Global.set_Level(current_level)
	Global.load_game()
	print("Level 5 wurde geladen!")
	
	MusicPlayer.is_active = false
	MusicPlayer.player.stop()
	
	GameManager.is_active = true
	GameManager.update_ui_visibility()
	
	music_toggle.focus_mode = Control.FOCUS_NONE
	music_toggle.button_pressed = !music_enabled
	music_toggle.pressed.connect(_on_music_toggle_pressed)

	if music_enabled and audio_player.playing == false:
		audio_player.play()
	
func toggle_music():
	music_enabled = !music_enabled
	if audio_player: 
		if music_enabled:
			audio_player.play()
		else:
			audio_player.stop()

func _on_music_toggle_pressed():
	toggle_music()
	music_toggle.button_pressed = !music_enabled
