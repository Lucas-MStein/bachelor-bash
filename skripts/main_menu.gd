extends Control

#@onready var music_player = get_node("/root/MusicPlayer")  # Globale Musik-Instanz
@onready var music_toggle = get_node("UI_Button/MusicToggleButton")             # Button für Musik an/aus
@onready var label_node: Label = get_node("Label")  

func _ready() -> void:
	GameManager.is_active = false
	GameManager.update_ui_visibility()
	MusicPlayer.is_active = true
	
	music_toggle.focus_mode = Control.FOCUS_NONE
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

	if OS.is_debug_build():
		InputMap.add_action("simulate_save")
		var event = InputEventKey.new()
		event.keycode = KEY_T
		InputMap.action_add_event("simulate_save", event)
	# Spielstand laden
	Global.load_game()

	# Begrüßungstext
	if Global.character != "":
		$Label2.text = "Ausgewählt: " + Global.character + " in Level " + str(Global.level)
func _input(event):
	if OS.is_debug_build() and event.is_action_pressed("simulate_save"):
		Global.simulate_save("CodeMaster", 2) # Simuliere CodeMaster auf Level 2
		Global.load_game() # Lade den gespeicherten Spielstand
		$Label2.text = "Simulierter Spielstand: " + Global.character + " in Level " + str(Global.level)

func _on_start_pressed() -> void:
	print("Start-Button gedrückt")
	print("Aktueller Charakter: ", Global.character, ", Level: ", Global.level)
	print("Global.character Typ: ", typeof(Global.character), ", Länge: ", Global.character.length())
	print("Global.level Typ: ", typeof(Global.level))
	
	if Global.character == "":
		$Label2.text = "Bitte wähle zuerst einen Charakter!"
		print("Kein Charakter ausgewählt!")
		return
	
	Global.save_game()
	
	var character_scene_map = {
		"CodeMaster": "res://scenes/Level_",
		"ProjektManager": "res://scenes/Level_",
		"WebDesigner": "res://scenes/Level_"
	}
	
	var base_path = character_scene_map.get(Global.character, "")
	if base_path != "":
		var scene_path = "res://scenes/Level_2_CodeMaster.tscn"
		print("Teste Szene: ", scene_path)
		if ResourceLoader.exists(scene_path):
			var scene = ResourceLoader.load(scene_path, "PackedScene")
			if scene and scene is PackedScene:
				var error = get_tree().change_scene_to_packed(scene)
				if error == OK:
					print("Szenenwechsel erfolgreich")
				else:
					print("Fehler beim Szenenwechsel: ", error)
			else:
				print("Fehler: Szene ungültig oder nicht geladen. Geladenes Objekt: ", scene)
		else:
			print("Szene nicht gefunden: ", scene_path)
		
		if MusicPlayer.music_enabled:
			MusicPlayer.player.stop()
	else:
		$Label2.text = "Ungültiger Charakter!"
		print("Ungültiger Charakter: ", Global.character)


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


func _on_spielstand_pressed() -> void:
	Global.load_game()
	if Global.character != "":
		$Label2.text = "Ausgewählt: " + Global.character + " in Level " + str(Global.level)
	else:
		$Label2.text = "Kein Spielstand vorhanden!"
