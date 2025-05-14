extends Node2D

@onready var music_toggle = get_node("/root/Ui/MusicToggleButton")
@onready var audio_player = $AudioStreamPlayer   
@onready var tutorial_label: Label = $UI_Tutorial/Panel/TutorialLabel  
@onready var tutorial = $UI_Tutorial/Panel

#@export var is_active: bool = false

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

# entered Area
func _on_area_controls_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Nutze die Pfeiltasten oder WASD um dich zu bewegen!"
		tutorial.visible = true

func _on_area_springen_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Drücke SPACE zum Springen!"
		tutorial.visible = true
		
func _on_area_enemies_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Springe auf den Gegner, um ihn zu besiegen!"
		tutorial.visible = true

func _on_area_credits_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Sammle alle 3 Credit-Points, um das Level abzuschließen!"
		tutorial.visible = true

func _on_area_obstacles_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Weiche dem Hindernis aus, damit du kein Leben verlierst!"
		tutorial.visible = true

func _on_area_endboss_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Du musst die Endgegner zweimal angreifen, um sie zu besiegen!"
		tutorial.visible = true

func _on_area_tür_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = "Du hast die Tür erreicht, das Level ist geschafft!"
		tutorial.visible = true 
	

func _on_area_wechsel_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	GameManager._reset_level()
	
# exited Area
func _on_area_controls_body_exited(body):
	if body.is_in_group("player"):
		tutorial_label.text = ""
		tutorial.visible = false

func _on_area_enemies_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = ""
		tutorial.visible = false

func _on_area_credits_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = ""
		tutorial.visible = false

func _on_area_endboss_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = ""
		tutorial.visible = false

func _on_area_obstacles_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = ""
		tutorial.visible = false

func _on_area_springen_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = ""
		tutorial.visible = false

func _on_area_tür_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tutorial_label.text = ""
		tutorial.visible = false
