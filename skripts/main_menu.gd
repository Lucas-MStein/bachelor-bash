extends Control

@onready var music_toggle = get_node("/root/Ui/MusicToggleButton")         # Button für Musik an/aus
@onready var label_node: Label = get_node("Label2")  # Label für Spielstand-Info
@onready var spielstand_button: Button = get_node("Spielstand")  # Spielstand laden Button

func _ready() -> void:
	GameManager.is_active = false
	GameManager.update_ui_visibility()
	
	MusicPlayer.is_active = true
	MusicPlayer.update_music_state()
	
	if music_toggle:
		music_toggle.focus_mode = Control.FOCUS_NONE
		music_toggle.button_pressed = !Global.music_enabled
		Global.music_enabled_changed.connect(_on_music_enabled_changed)
		Ui.music_toggle_pressed.connect(_on_music_toggle_pressed)
	
	if OS.is_debug_build() and Global.first_run:
		Global.reset_game()
		Global.first_run = false

	if OS.is_debug_build():
		InputMap.add_action("simulate_save")
		var event = InputEventKey.new()
		event.keycode = KEY_T
		InputMap.action_add_event("simulate_save", event)
	
	Global.load_game()
	update_spielstand_button()
	update_label()  # Neue Funktion zum Aktualisieren des Labels

func _input(event):
	if OS.is_debug_build() and event.is_action_pressed("simulate_save"):
		Global.simulate_save("CodeMaster", 5)
		update_spielstand_button()
		update_label()

func _on_start_pressed() -> void:
	if Global.character == "":
		label_node.text = "Bitte wähle zuerst einen Charakter!"
		return
	
	var base_scene_path = "res://scenes/Level_"
	if Global.level == 1:
		get_tree().change_scene_to_file("res://scenes/Welt_1.tscn")
	elif Global.level == 3:
		get_tree().change_scene_to_file("res://scenes/Welt_2.tscn")
	elif Global.level == 5:
		get_tree().change_scene_to_file("res://scenes/Welt_3.tscn")
	else:
		var scene_path = base_scene_path + str(Global.level) + "_" + Global.character + ".tscn"
		get_tree().change_scene_to_file(scene_path)

func _on_character_pressed() -> void:
	var char_select = load("res://scenes/character_select_menu.tscn").instantiate()
	add_child(char_select)
	# Nach Rückkehr aus Charakterauswahl Spielstand neu laden
	char_select.connect("tree_exited", func():
		Global.load_game()  # Spielstand neu laden
		update_label()
		update_spielstand_button()
	)

func _on_music_toggle_pressed():
	print("MainMenu: Music toggle pressed, Frame: ", Engine.get_frames_drawn())

func _on_music_enabled_changed(new_state: bool):
	music_toggle.button_pressed = !new_state
	print("MainMenu: Music enabled changed to ", new_state)

func _on_spielstand_pressed() -> void:
	Global.reset_game()
	Global.character = ""
	Global.level = 1
	Global.save_game()  # Spielstand speichern nach Reset
	update_label()
	update_spielstand_button()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_Tutorial_1.tscn")

func update_spielstand_button() -> void:
	if Global.character != "" and Global.level > 1:
		spielstand_button.visible = true
		spielstand_button.text = "Neues Spiel starten"
	else:
		spielstand_button.visible = false
		spielstand_button.text = "Spielstand laden"

func update_label() -> void:
	if Global.character != "":
		label_node.text = "Ausgewählt: " + Global.character + " in Level " + str(Global.level)
	else:
		label_node.text = "Bitte wähle einen Charakter aus."
