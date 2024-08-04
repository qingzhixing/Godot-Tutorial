extends CanvasLayer
@onready var animation_player = $AnimationPlayer
@onready var health_container = $"Health Bar/MarginContainer/Health Container"


func flash_screen():
	animation_player.play("screen_flash")

func set_health_display(health: int):
	health_container.set_health_display(health)
