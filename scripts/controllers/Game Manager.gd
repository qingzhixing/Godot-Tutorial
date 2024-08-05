extends Node

@export var coins: int = 0

@onready var coin_label = $CoinLabel
@onready var restart_count_down = $"Restart Count Down"
@onready var ui = %UI

func add_coin():
	coins += 1
	coin_label.text = "You collected " + str(coins) + " coins!"
	print("Coins: ", coins)

func handle_death():
	Engine.time_scale = 0.3
	ui.set_death_display(true)
	restart_count_down.start()

func handle_injury():
	ui.flash_screen()

func set_heart_ui(health: int):
	ui.set_health_display(health)

func _on_restart_count_down_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
