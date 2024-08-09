extends Node2D

@export_category("Textures")
@export var mud_puzzle: Resource
@export var granite_puzzle: Resource
@export var sand_puzlle: Resource
@export var stone_puzzle: Resource

@export var after_interaction_texture: Resource

@export_category("trophies")
@export var trophies: Array[PackedScene]

func interact_body_enter(body: Node2D):
	print("Interaction! From body: ", body.get_path())
	for trophy: PackedScene in trophies:
		var trophy_instance: Node2D = trophy.instantiate() as Node2D
		trophy_instance.position.x = position.x
		trophy_instance.position.y = position.y - 16
		print("root: ",get_tree().root.get_path())
		get_tree().root.call_deferred("add_child",trophy_instance,0.01)
