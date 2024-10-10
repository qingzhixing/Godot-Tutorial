extends Node2D

@export var block_collision: CollisionShape2D
@export var interact_collision: CollisionShape2D
@export var no_block_collision: bool = false

@onready var block_body = $BlockBody
@onready var interact_area = $InteractArea
signal on_interact_signal(interact_body: Node2D)
signal on_interact_exit_signal(interact_body: Node2D)

func _ready():
	if interact_collision == null:
		push_error("interact collision is null")
	else:
		interact_collision.get_parent().remove_child(interact_collision)
		interact_area.add_child(interact_collision)
		
	if no_block_collision:
		return
		
	if block_collision == null:
		push_error("block collision is null")
	else:
		block_collision.get_parent().remove_child(block_collision)
		block_body.add_child(block_collision)

	

func on_interact(interact_body: Node2D):
	on_interact_signal.emit(interact_body)


func on_interact_exit(interact_body: Node2D) -> void:
	on_interact_exit_signal.emit(interact_body)
