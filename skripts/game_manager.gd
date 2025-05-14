extends Node2D

@onready var heart_container = $CanvasLayer/HeartsContainer
@onready var coin_container = $CanvasLayer/CoinContainer
@onready var zurück: Button = $CanvasLayer/Zurück

var coins = 0
var heart = 3

var total_credits = 3

@export var is_active: bool = true

func _ready() -> void:
	update_ui_visibility()
	if is_active:
		print("GameManager is active")
	else:
		print("GameManager is disabled")
	
	print("HeartContainer:", heart_container)
	print("CoinContainer:", coin_container)
	
	if heart_container == null:
		print("Fehler: HeartContainer nicht gefunden!")
	if coin_container == null:
		print("Fehler: CoinContainer nicht gefunden!")
	
	_reset_level()
	
func set_is_active(value):
	is_active = value
	update_ui_visibility()  # Sichtbarkeit aktualisieren, wenn is_active geändert wird

func update_ui_visibility() -> void:
	if heart_container:
		heart_container.visible = is_active
		print("HeartContainer Sichtbarkeit:", heart_container.visible)
	if coin_container:
		coin_container.visible = is_active
		print("CoinContainer Sichtbarkeit:", coin_container.visible)
	zurück.visible = is_active
	
func _reset_level():
	print("reset_Level aufgerufen")
	coins = 0
	heart = 3
	
	if heart_container:
		heart_container.setMaxHearts(heart)
		heart_container.updateHearts(heart)
	else:
		print("Fehler: heart_container ist null!")
	
	if coin_container:
		for i in range(coin_container.get_child_count()):
			var coin_icon = coin_container.get_child(i)
			if coin_icon is TextureRect:
				coin_icon.visible = false
			else:
				print("Fehler: Coin-Icon", i, "ist kein Control!")

func add_coin():
	if is_active and coins < 3:
		var coin_icon = coin_container.get_child(coins)
		coin_icon.visible = true
		coins += 1

func damage_heart():
	if not is_active:
		return
	print("damage_heart aufgerufen, aktueller Herz-Wert:", heart)
	if heart >= 0:
		heart -= 1
		print("Neuer Herz-Wert:", heart)
		if heart_container:
			heart_container.updateHearts(heart)
			print("updateHearts aufgerufen mit heart:", heart)
		else:
			print("Fehler: heart_container ist null!")
	if heart == -1:
		print("Spiel wird neu geladen")
		get_tree().reload_current_scene()
		_reset_level()

func _on_zurück_pressed() -> void:
	Global.save_game()
	get_tree().change_scene_to_file("res://main_menu.tscn")
	_reset_level()
