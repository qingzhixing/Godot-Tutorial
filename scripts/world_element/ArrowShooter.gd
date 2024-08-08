extends Node2D

const Direction = _Direction.Direction

@export var arrow: PackedScene
@export var shoot_interval: float = 1

@onready var parent: Node2D = get_parent() as Node2D

func shoot(direction: Direction):
	var instance: ArrowController = arrow.instantiate() as ArrowController
	instance.position = get_parent().position + position
	instance.direction = direction
	get_tree().root.add_child(instance)
