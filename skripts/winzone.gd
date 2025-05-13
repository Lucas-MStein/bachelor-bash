extends Area2D

@export var base_scene_path: String = "res://scenes/"

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    if body.is_in_group("player"):
        if GameManager.coins >= 3:
            print("Level abgeschlossen – wechsle Szene")
            
            var next_scene_path = create_next_scene_path()
            print("Wechsle zu Szene:", next_scene_path)
            get_tree().change_scene_to_file(next_scene_path)
            GameManager._reset_level()
        else:
            print("Noch nicht genug Coins! Aktuell:", GameManager.coins)

func create_next_scene_path() -> String:
    var character = Global.character  
    print (character)
    var level = Global.level + 1
    print (level)
    Global.set_Level(level)
    # Dynamisches Erstellen des Szenenpfads
    var scene_path = base_scene_path + "Level_" + str(level) + "_" + character + ".tscn"
    return scene_path
