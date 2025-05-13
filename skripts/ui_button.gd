extends CanvasLayer

signal music_toggle_pressed()

@onready var music_toggle = $MusicToggleButton
var can_toggle: bool = true

func _ready() -> void:
	if music_toggle:
		music_toggle.focus_mode = Control.FOCUS_NONE
		music_toggle.button_pressed = !Global.music_enabled
		if music_toggle.pressed.is_connected(_on_music_toggle_pressed):
			music_toggle.pressed.disconnect(_on_music_toggle_pressed)
		music_toggle.pressed.connect(_on_music_toggle_pressed)
		Global.music_enabled_changed.connect(_on_music_enabled_changed)

func _on_music_toggle_pressed():
	if not can_toggle:
		return
	can_toggle = false
	print("Ui: Music toggle pressed, Frame: ", Engine.get_frames_drawn())
	music_toggle_pressed.emit()
	await get_tree().create_timer(0.2).timeout
	can_toggle = true

func _on_music_enabled_changed(new_state: bool):
	music_toggle.button_pressed = !new_state
	print("Ui: Music enabled changed to ", new_state)

func _on_exit_pressed() -> void:
	get_tree().quit()
