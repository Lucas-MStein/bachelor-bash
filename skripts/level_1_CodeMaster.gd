extends Node2D

@onready var music_toggle = $CanvasLayer/MusicToggleButton           
var music_enabled := true

func _ready() -> void:
	music_toggle.button_pressed = !music_enabled
	music_toggle.pressed.connect(_on_music_toggle_pressed)

	if music_enabled and $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
		
func _process(delta):
	
	pass
	
func toggle_music():
	music_enabled = !music_enabled
	if $AudioStreamPlayer: 
		$AudioStreamPlayer.stream_paused = !music_enabled

func _on_music_toggle_pressed():
	toggle_music()
	music_toggle.button_pressed = !music_enabled
