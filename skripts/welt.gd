extends Node2D

@onready var music_toggle = get_node("/root/Ui/MusicToggleButton")
@onready var music_player = get_node("/root/MusicPlayer")
@onready var timer: Timer = $Timer

func _ready() -> void:
	GameManager.is_active = false
	GameManager.update_ui_visibility()
	
	MusicPlayer.is_active = true
	music_toggle.button_pressed = false
	music_toggle.pressed.connect(_on_music_toggle_pressed)
	
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
func _on_timer_timeout() -> void:
	print("Welt-Timer abgelaufen")
	var base_scene_path = "res://scenes/Level_"
	var scene_path = base_scene_path + str(Global.level) + "_" + Global.character + ".tscn"
	get_tree().change_scene_to_file(scene_path)

func _on_music_toggle_pressed():
	music_player.toggle_music()
