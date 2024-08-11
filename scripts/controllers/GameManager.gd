extends Node

class_name GameManager

@export var debug_start_time_scale: float = 1

@onready var coin_label = $CoinLabel
@onready var restart_count_down = $"Restart Count Down"
@onready var MusicScene = get_node("/root/MusicScene")
@onready var music_script = MusicScene as Music

@export_category("bind_scenes")
@export var ui: UserInterface
@export var player: PlayerController
@export_category("in-game data")
@export var player_spawn_pos: Vector2

func display_coin_amount(value: int):
	coin_label.text = "You collected " + str(value) + " display_coins!"
	ui.set_coin_display(value)
	
func handle_death():
	Engine.time_scale = 0.3

	music_script.play_music(Music.MusicType.DEATH)

	ui.set_death_display(true)
	print("Wait player press R..")
	restart_count_down.start()

func spawn_teleport_player():
	player.position = player_spawn_pos

func handle_injury():
	ui.flash_screen()

func set_heart_ui(health: int):
	ui.set_health_display(health)

func rebirth_timeout():
	Engine.time_scale = 1.0
	ui.set_death_display(false)

	music_script.play_music(Music.MusicType.COMMON)
	
	spawn_teleport_player()

func set_spawn_pos(position: Vector2):
	player_spawn_pos = position

func _ready():
	Engine.time_scale = debug_start_time_scale
	spawn_teleport_player()
	music_script.play_music(Music.MusicType.COMMON)
