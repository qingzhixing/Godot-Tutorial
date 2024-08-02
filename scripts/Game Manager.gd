extends Node

var coins: int = 0

@onready var coin_label = $CoinLabel

func add_coin():
	coins += 1
	coin_label.text = "You collected " + str(coins) + " coins!"
	print("Coins: ", coins)
