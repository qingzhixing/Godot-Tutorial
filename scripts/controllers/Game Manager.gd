extends Node

class_name GameManager

@export var debug_start_time_scale: float = 1

@onready var coin_label = $CoinLabel
@onready var restart_count_down = $"Restart Count Down"

@export_category("bind_scenes")
@export var ui: UserInterface
@export var player: PlayerController
@export_category("in-game data")
@export var player_target_pos: Node2D

func _ready():
	Engine.time_scale = debug_start_time_scale
	teleport_player()

func display_coin_amount(value: int):
	coin_label.text = "You collected " + str(value) + " display_coins!"
	ui.set_coin_display(value)
	
func handle_death():
	Engine.time_scale = 0.3
	ui.set_death_display(true)
	restart_count_down.start()

func teleport_player():
	player.position = player_target_pos.position

func handle_injury():
	ui.flash_screen()

func set_heart_ui(health: int):
	ui.set_health_display(health)

func restart_count_down_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
