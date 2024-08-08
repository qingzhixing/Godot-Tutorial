extends Node2D

class_name ArrowController

const Direction = _Direction.Direction

@onready var sprite_2d = $Sprite2D
@onready var entity = $EntityController

@export var direction: Direction = Direction.FORWARD

func handle_attack():
	for targert in entity.get_entered_attack_entities():
		if targert.entity_type != _EntityType.EntityType.ENEMY:
			return
		if targert.take_damage(entity.damage):
			queue_free()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_2d.flip_h = (direction != Direction.FORWARD)
	position.x += entity.speed * direction * delta
	handle_attack()
