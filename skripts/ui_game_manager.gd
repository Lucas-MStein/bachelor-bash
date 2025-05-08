extends CanvasLayer

var coins = 0
var heart = 3

@onready var heart_container = $HeartsContainer
@onready var coin_container = $CoinContainer

func _ready() -> void:
	
	print("HeartContainer:", heart_container)
	print("CoinContainer:", coin_container)
	
	if heart_container == null:
		print("Fehler: HeartContainer nicht gefunden!")
	if coin_container == null:
		print("Fehler: CoinContainer nicht gefunden!")
	
	_reset_level()

	
func _reset_level():
	coins = 0
	heart = 3
	
	heart_container.setMaxHearts(heart)
	heart_container.updateHearts(heart)
	
	if coin_container:
		for i in range(coin_container.get_child_count()):
			var coin_icon = coin_container.get_child(i)
			if coin_icon is TextureRect:
				coin_icon.visible = false
			else:
				print("Fehler: Coin-Icon", i, "ist kein Control!")

func add_coin():
	if coins < 3:
		var coin_icon = coin_container.get_child(coins)
		coin_icon.visible = true
		coins += 1

func damage_heart():
	if heart > 0:
		heart -= 1
		#heart_container.updateHearts(heart)
		print(heart)
	if heart < 0:
		get_tree().reload_current_scene()
		_reset_level()
