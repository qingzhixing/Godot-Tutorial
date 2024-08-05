extends Area2D

@onready var game_manager = % "Game Manager"
@onready var animation_player = $AnimationPlayer

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	game_manager.add_coin();
	animation_player.play("pick_up")
