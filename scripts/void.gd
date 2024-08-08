extends Node2D

const EntityController = preload("res://scripts/entity/entity_controller.gd")

@onready var entity_controller = $EntityController

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	for target in entity_controller.entered_attack_area:
		var parent = target.get_parent().get_parent()
		if !parent is EntityController:
			return ;
		var target_entity = parent as EntityController
		target_entity.take_damage(entity_controller.damage)
