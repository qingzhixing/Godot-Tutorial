extends Area2D
@onready var animation_player = $AnimationPlayer

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var player = body as PlayerController
	if player == null:
		return
	player.add_coin();
	animation_player.play("pick_up")
