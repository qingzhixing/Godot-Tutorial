extends Node2D

class_name EntityController

const EntityType = _EntityType.EntityType

@onready var timer = $Timer
@onready var attack_area = $EntityAreas/AttackArea
@onready var hit_area = $EntityAreas/HitArea

@export_category("entity_type")
@export var entity_type: EntityType = EntityType.STATIC
@export var attack_ignore_types: Array[EntityType]

@export_category("entity_data")
@export var health: int
@export var damage: int
@export var speed: float
@export var injury_interval: float = 0.6
@export var invincible: bool = false
@export var allow_attack: bool = true

var entered_area_without_filter: Array

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

# return success
func take_damage(_damage: int) -> bool:
	if invincible || is_died():
		return false
	if !can_injure:
		return true
	can_injure = false

	timer.wait_time = injury_interval
	timer.start()
	
	health -= _damage
	if !on_injured.is_null():
		on_injured.emit(_damage)
	if is_died():
		allow_attack = false
		if !on_died.is_null():
			on_died.emit()
	return true

func enable_injury():
	can_injure = true

func attack_area_entered(_hit_area: Area2D):
	if !allow_attack:
		return
	if _hit_area != hit_area:
		entered_area_without_filter.push_back(_hit_area)

func attack_area_exited(_hit_area: Area2D):
	var index = entered_area_without_filter.find(_hit_area)
	if index == -1:
		return
	entered_area_without_filter.remove_at(index)
	pass

func get_entered_attack_entities() -> Array[EntityController]:
	var entity_array: Array[EntityController] = []
	for target in entered_area_without_filter:
		var parent = target.get_parent().get_parent()
		if !parent is EntityController:
			continue
		var target_entity = parent as EntityController
		if attack_ignore_types.find(target_entity.entity_type) == -1:
			entity_array.push_back(target_entity)
	return entity_array
