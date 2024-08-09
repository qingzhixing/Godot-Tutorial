extends Node2D

const TextureType = _TextureType.TextureType

@onready var puzzle_sprite = $PuzzleSprite
@onready var interaction_success = $SFX/InteractionSuccess
@onready var interaction_faild = $SFX/InteractionFaild
@onready var animation_player = $AnimationPlayer

@export_category("trophies")
@export var trophies: Array[PackedScene]

@export_category("info")
@export var texture_type: TextureType = TextureType.MUD
@export var interact_once: bool = true
@export_range(0, 1) var interacted_white_rate = 0.8

@export_category("Textures")
@export var mud_puzzle: Resource
@export var granite_puzzle: Resource
@export var sand_puzlle: Resource
@export var stone_puzzle: Resource

@export var after_interaction_texture: Resource

var interactable: bool = true

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

@warning_ignore("unused_parameter")
func interact_body_enter(body: Node2D):
	if !interactable:
		interaction_faild.play()
		return
	interaction_success.play()
	animation_player.play("interact")
	if interact_once:
		interactable = false
		puzzle_sprite.modulate.r *= interacted_white_rate
		puzzle_sprite.modulate.g *= interacted_white_rate
		puzzle_sprite.modulate.b *= interacted_white_rate

	for trophy: PackedScene in trophies:
		var trophy_instance: Node2D = trophy.instantiate() as Node2D
		trophy_instance.position.x = position.x
		trophy_instance.position.y = position.y - 16
		print("root: ", get_tree().root.get_path())
		get_tree().root.call_deferred("add_child", trophy_instance, 0.01)
