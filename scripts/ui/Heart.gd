extends Control
@onready var animation_player = $":AnimationPlayer"
@onready var heart_texture = $":Heart Texture"
#@export var animation_player: AnimationPlayer
#@export var heart_texture: TextureRect

func set_full():
	print("full")
	animation_player.play("full")

func set_half():
	print("half")
	animation_player.play("half")

func set_empty():
	print("empty")
	animation_player.play("empty")

func _init():
	print("Heart Init!")
