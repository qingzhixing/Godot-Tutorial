extends Control
@onready var animation_player = $AnimationPlayer

func set_full():
	animation_player.play("full")

func set_half():
	animation_player.play("half")

func set_empty():
	animation_player.play("empty")
