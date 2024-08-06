extends Area2D

@export var damage: float
@export var interval: float
var player_exist = false
var player = null

const PlayerController = preload("res://scripts/entity/PlayerController.gd")

@warning_ignore("unused_parameter")
func _process(delta):
	if player == null:
		return
	if player_exist:
		player.entity_data.take_damage(damage)

@warning_ignore("unused_parameter")
func _on_body_exited(body):
	player_exist = false

func _on_body_entered(body):
	player_exist = true
	player = body as PlayerController
