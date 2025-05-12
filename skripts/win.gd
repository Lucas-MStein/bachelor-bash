extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.is_active = false
	GameManager.update_ui_visibility()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_reset_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
