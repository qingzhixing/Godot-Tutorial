extends Node2D

@export var on_state_time = 0.5
@export var save_off: Resource
@export var save_on: Resource

@onready var timer = $SwitchOffTimer
@onready var sprite = $SaveSprite
@onready var game_manager = %GameManager as GameManager


var save_state: bool = false

func save_handler():
	game_manager.set_spawn_pos(position)
	pass

func set_off():
	if !save_state:
		return
	save_state = false

func set_on():
	if save_state:
		return
	save_state = true
	save_handler()
	timer.start()

@warning_ignore("unused_parameter")
func _process(delta):
	if save_state == false:
		sprite.texture = save_off
	else:
		sprite.texture = save_on
