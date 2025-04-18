extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scences/review.tscn")


func _on_character_pressed() -> void:
	print("Character pressed")


func _on_options_pressed() -> void:
	print("Options pressed")


func _on_exit_pressed() -> void:
	get_tree().quit()
