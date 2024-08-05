extends Container

func deep_duplicate(node: Node, id: int) -> Node:
	var new_node = node.duplicate()
	new_node.name = node.name + str(id)
	clear_children(new_node)
	for child in node.get_children(true):
		if child == null:
			print("\nERROR! duplicating a NULL child!\n")
		var new_child = child.duplicate()
		new_child.name = child.name + str(id)
		# new_child.get_parent().remove_child(new_child)
		new_node.add_child(new_child)
	return new_node

func clear_children(node: Node):
	print("clearing children: " + node.name)

	var childs = node.get_children(true)
	print("child amount: ", childs.size())

	print("before scene tree:")
	print(node.get_tree_string())

	if childs != null:
		for child in childs:
			child.free()

	print("after scene tree:")
	print(node.get_tree_string())

func generate_hearts(health: int):
	@warning_ignore("integer_division")
	var heart_sum = (health + 1) / 2
	var last_half = health % 2

	print("Adding Children")
	for heart_id in range(heart_sum):
		print("constructing heart id: ", heart_id)

		var new_child: Control = Control.new()
		#codes here

		add_child(new_child)

func print_scene_tree():
	print(get_tree_string())

func set_health_display(health: int):
	print("\nsetting health: ", health)
	# return
	if health < 0:
		return

	clear_children(self)
	generate_hearts(health)
	print_scene_tree()
	
func _ready():
	pass
