extends Control

@onready var music_toggle = get_node("/root/Ui/MusicToggleButton")

func _ready():
	if music_toggle == null:
		print("ERROR: MusicToggleButton nicht gefunden!")
	
	GameManager.is_active = false
	GameManager.update_ui_visibility()
	
	MusicPlayer.is_active = true
	MusicPlayer.update_music_state()
	
	music_toggle.focus_mode = Control.FOCUS_NONE
	music_toggle.button_pressed = !Global.music_enabled
	Global.music_enabled_changed.connect(_on_music_enabled_changed)
	Ui.music_toggle_pressed.connect(_on_music_toggle_pressed)
	
	$VBoxContainer/HBoxContainer/Char1Button.pressed.connect(func(): _select_character("CodeMaster"))
	$VBoxContainer/HBoxContainer/Char2Button.pressed.connect(func(): _select_character("ProjektManager"))
	$VBoxContainer/HBoxContainer/Char3Button.pressed.connect(func(): _select_character("WebDesigner"))

func _select_character(charactername: String):
	Global.character = charactername
	$VBoxContainer/InfoLabel.text = "Ausgewählt: " + charactername
	Global.save_game()
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_music_toggle_pressed():
	print("CharacterSelect: Music toggle pressed, Frame: ", Engine.get_frames_drawn())

func _on_music_enabled_changed(new_state: bool):
	music_toggle.button_pressed = !new_state
	print("CharacterSelect: Music enabled changed to ", new_state)

func _on_exit_pressed() -> void:
	get_tree().quit()
