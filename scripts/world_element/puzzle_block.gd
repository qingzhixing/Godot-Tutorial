extends Node2D

const TextureType = _TextureType.TextureType

@onready var puzzle_sprite = $PuzzleSprite
@onready var interaction_success = $SFX/InteractionSuccess
@onready var interaction_faild = $SFX/InteractionFaild

@export_category("trophies")
@export var trophies: Array[PackedScene]

@export_category("info")
@export var texture_type: TextureType = TextureType.MUD
@export var interactable: bool = true

@export_category("Textures")
@export var mud_puzzle: Resource
@export var granite_puzzle: Resource
@export var sand_puzlle: Resource
@export var stone_puzzle: Resource

@export var after_interaction_texture: Resource

func switch_texture():
	if texture_type == TextureType.MUD:
		puzzle_sprite.texture = mud_puzzle
		return
	if texture_type == TextureType.COLD:
		puzzle_sprite.texture = stone_puzzle
		return
	if texture_type == TextureType.SAND:
		puzzle_sprite.texture = sand_puzlle
		return
	if texture_type == TextureType.GRANITE:
		puzzle_sprite.texture = granite_puzzle
		return

func _ready():
	switch_texture()

func interact_body_enter(body: Node2D):
	if !interactable:
		interaction_faild.play()
		return
	interaction_success.play()
	interactable = false
	puzzle_sprite.texture = after_interaction_texture
	print("Interaction! From body: ", body.get_path())
	for trophy: PackedScene in trophies:
		var trophy_instance: Node2D = trophy.instantiate() as Node2D
		trophy_instance.position.x = position.x
		trophy_instance.position.y = position.y - 16
		print("root: ", get_tree().root.get_path())
		get_tree().root.call_deferred("add_child", trophy_instance, 0.01)
