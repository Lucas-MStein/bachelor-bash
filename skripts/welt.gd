extends Node2D

@onready var music_toggle = get_node("/root/Ui/MusicToggleButton")
@onready var music_player = get_node("/root/MusicPlayer")
@onready var timer: Timer = $Timer

func _ready() -> void:
	GameManager.is_active = false
	GameManager.update_ui_visibility()
	
	MusicPlayer.is_active = true
	MusicPlayer.update_music_state()

	music_toggle.focus_mode = Control.FOCUS_NONE
	music_toggle.button_pressed = !Global.music_enabled
	Global.music_enabled_changed.connect(_on_music_enabled_changed)
	Ui.music_toggle_pressed.connect(_on_music_toggle_pressed)
	
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout() -> void:
	print("Welt-Timer abgelaufen")
	var base_scene_path = "res://scenes/Level_"
	var scene_path = base_scene_path + str(Global.level) + "_" + Global.character + ".tscn"
	get_tree().change_scene_to_file(scene_path)

func _on_music_toggle_pressed():
	print("Welt: Music toggle pressed, Frame: ", Engine.get_frames_drawn())

func _on_music_enabled_changed(new_state: bool):
	music_toggle.button_pressed = !new_state
	print("Welt: Music enabled changed to ", new_state)
