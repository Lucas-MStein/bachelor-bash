extends Control

@onready var label_node: Label = get_node("Label")

func _ready() -> void:
	# Entwickler-Test: Spielstand nur beim ersten Start in Debug löschen
	if OS.is_debug_build() and Global.first_run:
		Global.character = ""
		Global.level = 1
		var dir := DirAccess.open("user://")
		if dir.file_exists("savegame.save"):
			dir.remove("savegame.save")
		Global.first_run = false  # Wichtig: Nur einmal löschen

	# Savegame laden (falls vorhanden)
	Global.load_game()

	# Begrüßungstext setzen
	if Global.character != "":
		label_node.text = "Willkommen zurück, " + Global.character + "!"
	else:
		label_node.text = "Bachelor Bash"

func _on_start_pressed() -> void:
	if Global.character == "":
		label_node.text = "Bitte wähle zuerst einen Charakter!"
	else:
		Global.save_game()
		get_tree().change_scene_to_file("res://Level1.tscn")

func _on_character_pressed() -> void:
	get_tree().change_scene_to_file("res://character_select_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()