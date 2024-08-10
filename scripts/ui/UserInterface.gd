extends CanvasLayer

class_name UserInterface

@onready var animation_player = $AnimationPlayer
@onready var health_container = $"Health Bar/MarginContainer/Health Container"
@onready var death_display = $"Death Display"
@onready var coin_display = $"Coin Display"

func flash_screen():
	animation_player.play("screen_flash")

func set_health_display(health: int):
	health_container.set_health_display(health)

func set_death_display(display:bool):
	death_display.visible=display
	
func set_coin_display(value:int):
	coin_display.set_coin_display(value)

func _ready():
	set_death_display(false)
