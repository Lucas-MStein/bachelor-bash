extends Node2D

@onready var music_toggle = $UI_Button/MusicToggleButton
@onready var audio_player = $AudioStreamPlayer   
@onready var tutorial_label: Label = $UI_Tutorial/TutorialLabel      
var music_enabled := true

func _ready() -> void:	
    tutorial_label.text = ""  # Starttext leeren

    Global.set_Level(1)
    
    MusicPlayer.is_active = false
    MusicPlayer.player.stop()
    
    GameManager.is_active = true
    GameManager.update_ui_visibility()
    
    music_toggle.focus_mode = Control.FOCUS_NONE
    music_toggle.button_pressed = !music_enabled
    music_toggle.pressed.connect(_on_music_toggle_pressed)

    if music_enabled and not audio_player.playing:
        audio_player.play()

func toggle_music():
    music_enabled = !music_enabled
    if audio_player: 
        if music_enabled:
            audio_player.play()
        else:
            audio_player.stop()

func _on_music_toggle_pressed():
    toggle_music()
    music_toggle.button_pressed = !music_enabled

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
