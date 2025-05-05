extends Control

@onready var music_toggle = $MusicToggleButton  # Verweist auf den Button im SceneTree

func _ready():
	# Buttons mit Charakteren verbinden
	$VBoxContainer/HBoxContainer/Char1Button.pressed.connect(func(): _select_character("Projekt-Manager"))
	$VBoxContainer/HBoxContainer/Char2Button.pressed.connect(func(): _select_character("Web-Designer"))
	$VBoxContainer/HBoxContainer/Char3Button.pressed.connect(func(): _select_character("Code-Master"))

	# Musik-Button initialisieren
	music_toggle.button_pressed = false
	music_toggle.pressed.connect(_on_music_toggle_pressed)

func _select_character(name: String):
	Global.character = name
	$VBoxContainer/InfoLabel.text = "Ausgewählt: " + name
	Global.save_game()

	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_music_toggle_pressed():
	var music_player = get_node("/root/MusicPlayer")  # Passe den Pfad ggf. an!
	music_player.toggle_music()
