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
	if level<6:
		if level == 1:
			"res://scenes/Welt_1.tscn"
			var scene_path = base_scene_path + "Level_" + str(level) + "_" + character + ".tscn"
			return scene_path
		elif level == 3:
			"res://scenes/Welt_2.tscn"
			var scene_path = base_scene_path + "Level_" + str(level) + "_" + character + ".tscn"
			return scene_path
		elif level ==5:
			"res://scenes/Welt_3.tscn"
			var scene_path = base_scene_path + "Level_" + str(level) + "_" + character + ".tscn"
			return scene_path
		else: 
			var scene_path = base_scene_path + "Level_" + str(level) + "_" + character + ".tscn"
			return scene_path
	else:
		return "res://scenes/win.tscn"
