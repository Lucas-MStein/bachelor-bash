extends Node

var character: String = ""
var level: int = 1
var first_run := true

func save_game():
    var save_data = {
        "character": character,
        "level": level
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
