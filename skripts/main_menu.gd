extends Control

@onready var music_player = get_node("/root/MusicPlayer")  # Globale Musik-Instanz
@onready var music_toggle = $MusicToggleButton              # Button für Musik an/aus
@onready var label_node: Label = get_node("Label")  

func _ready() -> void:
	
	music_toggle.button_pressed = !MusicPlayer.music_enabled
	music_toggle.pressed.connect(_on_music_toggle_pressed)
	# Entwickler-Test: Speicherstand löschen beim ersten Start (Debug-Modus)
	if OS.is_debug_build() and Global.first_run:
		Global.character = ""
		Global.level = 1
		var dir := DirAccess.open("user://")
		if dir.file_exists("savegame.save"):
			dir.remove("savegame.save")
		Global.first_run = false

	# Spielstand laden
	Global.load_game()

	# Begrüßungstext
	if Global.character != "":
		$Label2.text = "Ausgewählt: " + Global.character + "!"
	

func _on_start_pressed() -> void:
	if Global.character == "":
		$Label2.text = "Bitte wähle zuerst einen Charakter!"
	else:
		Global.save_game()
		get_tree().change_scene_to_file("res://scenes/Level_1.tscn")
		if MusicPlayer.music_enabled:
			MusicPlayer.toggle_music()


func _on_character_pressed() -> void:
	var char_select = load("res://scenes/character_select_menu.tscn").instantiate()
	add_child(char_select)

func _on_options_pressed() -> void:
	print("Options pressed")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_music_toggle_pressed():
	MusicPlayer.toggle_music()
	music_toggle.button_pressed = !MusicPlayer.music_enabled
