extends Control
var animation_player: AnimationPlayer
var heart_texture: TextureRect
#@export var animation_player: AnimationPlayer
#@export var heart_texture: TextureRect

# TODO:When instant Heart object,call these functions will lead to Errors
#	Invalid call.Noneexistent function 'play' is base 'Nil'
func set_full():
	print("full")
	animation_player.play("full")

func set_half():
	print("half")
	animation_player.play("half")

func set_empty():
	print("empty")
	animation_player.play("empty")

func rebind():
	print("\n\nRebinding: ", name)
	
	animation_player = null
	heart_texture = null

	print("    scene_tree:")
	print(get_tree_string())
	# Failed
	# animation_player = get_node("./AnimationPlayer")
	# heart_texture = get_node("./Heart Texture")
	# TODO:尝试获取克隆子节点失败，继续尝试
	for child in get_children(true):
		if child.get_class() == "AnimationPlayer":
			animation_player = child
		if child.get_class() == "TextureRect":
			heart_texture = child
	if animation_player == null:
		print("bind animation_player failed")
	if heart_texture == null:
		print("bind heart_texture failed")

func _ready():
	print("Heart Init!")
	rebind()
