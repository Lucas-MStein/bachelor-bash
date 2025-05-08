extends Control

@onready var music_toggle = get_node("CanvasLayer/MusicToggleButton")
@onready var music_player = get_node("/root/MusicPlayer")

func _ready():
    $VBoxContainer/HBoxContainer/Char1Button.pressed.connect(func(): _select_character("Codemaster"))
    $VBoxContainer/HBoxContainer/Char2Button.pressed.connect(func(): _select_character("Projektmanager"))
    $VBoxContainer/HBoxContainer/Char3Button.pressed.connect(func(): _select_character("Webdesigner"))

    music_toggle.button_pressed = false
    music_toggle.pressed.connect(_on_music_toggle_pressed)

func _select_character(name: String):
    Global.character = name
    $VBoxContainer/InfoLabel.text = "Ausgewählt: " + name
    Global.save_game()

    await get_tree().create_timer(1.5).timeout
    get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_music_toggle_pressed():
    var music_player = get_node("/root/MusicPlayer")
    music_player.toggle_music()
    
func _on_exit_pressed() -> void:
    get_tree().quit()
