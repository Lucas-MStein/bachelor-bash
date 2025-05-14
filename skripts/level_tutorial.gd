extends Node2D

@onready var music_toggle = get_node("/root/Ui/MusicToggleButton")
@onready var audio_player = $AudioStreamPlayer   
@onready var tutorial_label: Label = $UI_Tutorial/TutorialLabel      

func _ready() -> void:	
	tutorial_label.text = ""  # Starttext leeren

	GameManager.is_active = true
	GameManager.update_ui_visibility()
	
	MusicPlayer.is_active = true
	MusicPlayer.update_music_state()
	
	if music_toggle:
		music_toggle.focus_mode = Control.FOCUS_NONE
		music_toggle.button_pressed = !Global.music_enabled
		Global.music_enabled_changed.connect(_on_music_enabled_changed)
		Ui.music_toggle_pressed.connect(_on_music_toggle_pressed)

func _on_music_toggle_pressed():
	print("MainMenu: Music toggle pressed, Frame: ", Engine.get_frames_drawn())

func _on_music_enabled_changed(new_state: bool):
	music_toggle.button_pressed = !new_state
	print("MainMenu: Music enabled changed to ", new_state)

# Signale für Area2D-Triggerzonen
func _on_area_controls_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Nutze ←A  D→ zum Bewegen und SPACE zum Springen.\nDrücke ↓S zum Rutschen!"

func _on_area_enemies_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Springe auf Gegner, um sie zu besiegen!"

func _on_area_credits_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Sammle Credit Points ein, um das Level zu schaffen!"

func _on_area_controls_body_exited(body):
	if body.is_in_group("player"):
		tutorial_label.text = ""

func _on_area_enemies_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = ""

func _on_area_credits_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = ""


func _on_area_tür_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
