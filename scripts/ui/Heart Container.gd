extends Container
const Heart = preload("res://scripts/ui/Heart.gd")
const HeartResource = preload("res://prefabs/ui/heart.tscn")
@export var heart_template: Control

func deep_duplicate(node: Node) -> Node:
	var new_node = node.duplicate()
	for child in node.get_children(true):
		new_node.add_child(child)
	return new_node

func clear_children():
	var childs = get_children(false)
	print("child amount: ", childs.size())
	if childs != null:
		for child in childs:
			child.queue_free()

func generate_hearts(health: int):
	@warning_ignore("integer_division")
	var heart_sum = (health + 1) / 2
	var last_half = health % 2

	print("Adding Children")
	for heart_id in range(heart_sum):
		print("constructing heart id: ", heart_id)

		var new_child_node = deep_duplicate(heart_template)
		print("New instance child amount:", new_child_node.get_child_count(true))
		new_child_node.set_script(Heart)
		var new_child = new_child_node as Heart

		new_child_node.visible = true

		if heart_id == heart_sum - 1:
			if last_half == 1:
				new_child.set_half()
				print("heart is half")
			else:
				new_child.set_full()
				print("heart is full")
		else:
			new_child.set_full()
			print("heart is full")

		add_child(new_child)

func set_health_display(health: int):
	print("\nsetting health: ", health)
	# return
	if health < 0:
		return

	if heart_template == null:
		print("ERROR! Heart Template is null!")
		return

	clear_children()
	generate_hearts(health)
	
func _ready():
	pass
