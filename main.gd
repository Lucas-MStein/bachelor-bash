extends Node

@onready var music_player = $MusicRoot/MusicPlayer
@onready var content = $Content

func play_music():
	music_player.play()

func _ready() -> void:
	play_music()
	switch_to("res://main_menu.tscn") # Passe ggf. Pfad an

func switch_to(scene_path: String):
	var scene = load(scene_path).instantiate()

	for child in content.get_children():
		child.queue_free()

	content.add_child(scene)
