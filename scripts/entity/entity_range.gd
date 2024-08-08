extends Node

@onready var attack_range = $AttackRange
@onready var hit_range = $HitRange

@export var attack_area_collition: CollisionShape2D
@export var hit_area_collition: CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if attack_area_collition == null:
		print("WARNING! attack_area_collition is null")
	else:
		attack_area_collition.get_parent().remove_child(attack_area_collition)
		attack_range.add_child(attack_area_collition)
	if hit_area_collition == null:
		print("WARNING! hit_area_collition is null")
	else:
		hit_area_collition.get_parent().remove_child(hit_area_collition)
		hit_range.add_child(hit_area_collition)
	pass
