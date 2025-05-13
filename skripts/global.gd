extends Node

signal music_enabled_changed(new_state: bool)

var character: String = ""
var level: int = 1
var first_run := true
var music_enabled: bool = true:
	set(value):
		music_enabled = value
		music_enabled_changed.emit(value)
		save_game()

func save_game():
	var save_data = {
		"character": character,
		"level": level,
		"music_enabled": music_enabled
	}
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	file.store_var(save_data)
	file.close()

func load_game():
	if FileAccess.file_exists("user://savegame.save"):
		var file = FileAccess.open("user://savegame.save", FileAccess.READ)
		var save_data = file.get_var()
		file.close()
		character = save_data.get("character", "")
		level = save_data.get("level", 1)
		music_enabled = save_data.get("music_enabled", true)

func set_Level(playerLevel: int):
	level = playerLevel
	save_game()

func simulate_save(character_name: String, level_number: int):
	character = character_name
	level = level_number
	save_game()
	print("Simulierter Spielstand gespeichert: ", character, " Level: ", level)

func reset_game():
	if FileAccess.file_exists("user://savegame.save"):
		var dir = DirAccess.open("user://")
		dir.remove("savegame.save")
	character = ""
	level = 1
	first_run = true
	music_enabled = true
	print("Spielstand zurückgesetzt: Kein gespeicherter Spielstand vorhanden.")
