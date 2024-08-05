extends Area2D

@onready var timer = $Timer
@export var damage: float
@export var interval: float
var enable_damage = true
var player_exist = false
var player = null

const PlayerController = preload("res://scripts/entity/PlayerController.gd")

@warning_ignore("unused_parameter")
func _process(delta):
	if player == null:
		return
	if player_exist && enable_damage:
		player.entity_data.take_damage(damage)
		timer.wait_time = interval
		enable_damage = false
		timer.start()
		
func _on_timer_timeout():
	enable_damage = true

@warning_ignore("unused_parameter")
func _on_body_exited(body):
	player_exist = false

func _on_body_entered(body):
	player_exist = true
	player = body as PlayerController
