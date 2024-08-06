extends Node

@onready var timer = $Timer

@export var health: int
@export var damage: int
@export var speed: float
@export var injury_interval: float = 0.6

var can_injure = true

signal on_died
signal on_injured(damage: float)

func is_died():
	return health <= 0;
	
func _init():
	health = 0
	damage = 0
	speed = 0

func take_damage(_damage: int):
	if !can_injure:
		return
	can_injure = false

	timer.wait_time = injury_interval
	timer.timeout.connect(enable_injury)
	timer.one_shot = true
	timer.start()
	
	health -= _damage
	if !on_injured.is_null():
		on_injured.emit(damage)
	if is_died() && !on_died.is_null():
		on_died.emit()

func enable_injury():
	can_injure = true
