extends Node

class_name GameManager

@export var debug_start_time_scale: float = 1

@onready var coin_label = $CoinLabel
@onready var restart_count_down = $"Restart Count Down"
@onready var ui = %UI

func _ready():
	Engine.time_scale = debug_start_time_scale

func display_coin_amount(value: int):
	coin_label.text = "You collected " + str(value) + " display_coins!"

func handle_death():
	Engine.time_scale = 0.3
	ui.set_death_display(true)
	restart_count_down.start()

func handle_injury():
	ui.flash_screen()

func set_heart_ui(health: int):
	ui.set_health_display(health)

func restart_count_down_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
