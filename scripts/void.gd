extends Node2D

@onready var entity_controller = $EntityController

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	for target in entity_controller.get_entered_attack_entities():
		target.take_damage(entity_controller.damage)
