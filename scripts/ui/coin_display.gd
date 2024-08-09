extends Control

@onready var coin_amount = $CoinAmount

func set_coin_display(amount:int):
	coin_amount.text = str(amount)
