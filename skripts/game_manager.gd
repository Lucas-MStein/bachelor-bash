extends Node2D

var coins = 0

@onready var coin_label: Label = $CanvasLayer/CoinLabel
@onready var coin_container: GridContainer = $CanvasLayer/CoinContainer

func add_coin():
	coin_label.text = "Coins: " + str(coins)
	if coins < 3:
		var coin_icon = coin_container.get_child(coins)
		coin_icon.visible = true
		coins += 1
