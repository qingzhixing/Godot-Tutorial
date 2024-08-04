extends CanvasLayer
@onready var animation_player = $AnimationPlayer

func flash_screen():
	animation_player.play("screen_flash")
