extends CanvasLayer
@onready var animation_player = $AnimationPlayer
@onready var health_container = $"Health Bar/MarginContainer/Health Container"
@onready var death_display = $"Death Display"


func flash_screen():
	animation_player.play("screen_flash")

func set_health_display(health: int):
	health_container.set_health_display(health)

func set_death_display(display:bool):
	death_display.visible=display

func _ready():
	set_death_display(false)
