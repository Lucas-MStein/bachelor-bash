extends Node2D

var coins = 0
var heart = 3

@onready var coin_container = get_node("CanvasLayer/CoinContainer")

@onready var heart_container = get_node("CanvasLayer/HeartContainer")

@export var active_heart: Texture
@export var inactive_heart: Texture


func add_coin():
    if coins < 3:
        var coin_icon = coin_container.get_child(coins)
        coin_icon.visible = true
        coins += 1
        
func damage_heart():
    if heart > 0:
        heart -= 1
        var heart_icon = heart_container.get_child(heart)
        if heart_icon is TextureRect:
            heart_icon.texture = inactive_heart
    else:
        print("Spieler hat keine Leben mehr")
