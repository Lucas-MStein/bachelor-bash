extends Node2D

func _ready() -> void:
	GameManager.is_active = false
	GameManager.update_ui_visibility()

func _on_reset_pressed() -> void:
	Global.reset_game()
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
