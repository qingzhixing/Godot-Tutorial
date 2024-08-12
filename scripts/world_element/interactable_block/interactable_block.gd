extends Node2D

@export var block_collision: CollisionShape2D
@export var interact_collision: CollisionShape2D

@onready var block_body = $BlockBody
@onready var interact_area = $InteractArea
signal on_interact_signal(interact_body: Node2D)

func _ready():
	if block_collision == null:
		push_error("block collision is null")
	else:
		block_collision.get_parent().remove_child(block_collision)
		block_body.add_child(block_collision)

	if interact_collision == null:
		push_error("interact collision is null")
	else:
		interact_collision.get_parent().remove_child(interact_collision)
		interact_area.add_child(interact_collision)

func on_interact(interact_body: Node2D):
	on_interact_signal.emit(interact_body)
