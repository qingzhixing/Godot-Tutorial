extends Node2D

@onready var timer = $Timer
@onready var attack_area = $EntityAreas/AttackArea
@onready var hit_area = $EntityAreas/HitArea

@export_category("entity_data")
@export var health: int
@export var damage: int
@export var speed: float
@export var injury_interval: float = 0.6
@export var invincible: bool = false

var entered_attack_area: Array

@export_category("entity_range")
@export var attack_area_collition: CollisionShape2D
@export var hit_area_collition: CollisionShape2D

var can_injure = true

signal on_died
signal on_injured(damage: float)

	
func _init():
	health = 0
	damage = 0
	speed = 0

func _ready():
	timer.timeout.connect(enable_injury)
	timer.one_shot = true

	if attack_area_collition == null:
		print("WARNING! attack_area_collition is null")
	else:
		attack_area_collition.get_parent().remove_child(attack_area_collition)
		attack_area.add_child(attack_area_collition)
	if hit_area_collition == null:
		print("WARNING! hit_area_collition is null")
	else:
		hit_area_collition.get_parent().remove_child(hit_area_collition)
		hit_area.add_child(hit_area_collition)

func is_died():
	return !invincible && health <= 0;

func take_damage(_damage: int):
	if invincible || !can_injure || is_died():
		return
	can_injure = false

	timer.wait_time = injury_interval
	timer.start()
	
	health -= _damage
	if !on_injured.is_null():
		on_injured.emit(_damage)
	if is_died() && !on_died.is_null():
		on_died.emit()

func enable_injury():
	can_injure = true

func attack_area_entered(_hit_area: Area2D):
	# print("attack_area_entered: ", _hit_area.name)
	# print("    path: ", _hit_area.get_path())
	# print("    root: ", _hit_area.get_instance_id())
	# print("self area: ", hit_area.name)
	# print("    path: ", hit_area.get_path())
	# print("    root: ", hit_area.get_instance_id())

	if _hit_area != hit_area:
		entered_attack_area.push_back(_hit_area)
		# print("new instance!")
	# else:
		# print("entered hit area is own hit area")
	pass

func attack_area_exited(_hit_area: Area2D):
	var index = entered_attack_area.find(_hit_area)
	if index == -1:
		return
	entered_attack_area.remove_at(index)
	# print("removed: ", _hit_area.name)
	pass
