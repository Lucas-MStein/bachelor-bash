extends Control

func _ready():
	$VBoxContainer/HBoxContainer/Char1Button.pressed.connect(func(): _select_character("Projekt-Manager"))
	$VBoxContainer/HBoxContainer/Char2Button.pressed.connect(func(): _select_character("Web-Designer"))
	$VBoxContainer/HBoxContainer/Char3Button.pressed.connect(func(): _select_character("Code-Master"))

func _select_character(name: String):
	Global.character = name
	$VBoxContainer/InfoLabel.text = "Ausgewählt: " + name
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")
