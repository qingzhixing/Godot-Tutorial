extends Node2D

const Direction = Constants.Direction
const EntityController = preload("res://scripts/entity/entity_controller.gd")

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right_down = $RayCastRightDown
@onready var ray_cast_left_down = $RayCastLeftDown
@onready var animated_sprite = $AnimatedSprite2D
@onready var killzone = $Killzone
@onready var entity = $Entity

@export_enum("green", "purple") var slime_type: String
@export var direction: Direction

func _ready():
	killzone.damage = entity.damage
	if slime_type == "green":
		animated_sprite.play("idle_green")
	else:
		animated_sprite.play("idle_purple")
	pass

func handle_direction():
	if (ray_cast_left.is_colliding() || (!ray_cast_left_down.is_colliding())):
		# print("Move Forward")
		direction = Direction.FORWARD
		animated_sprite.flip_h = false
	if (ray_cast_right.is_colliding() || (!ray_cast_right_down.is_colliding())):
		# print("Move Backward")
		direction = Direction.BACKWARD
		animated_sprite.flip_h = true
	pass

func handle_damage():
	for target in entity.entered_attack_area:
		var parent = target.get_parent().get_parent()
		if !parent is EntityController:
			return
		var target_entity = parent as EntityController
		target_entity.take_damage(entity.damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_direction()
	position.x += direction * entity.speed * delta;
	handle_damage()
