extends Node2D

const Direction = _Direction.Direction
const EntityController = preload("res://scripts/entity/entity_controller.gd")

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right_down = $RayCastRightDown
@onready var ray_cast_left_down = $RayCastLeftDown
@onready var animated_sprite = $AnimatedSprite2D
@onready var entity = $Entity
@onready var enemy_hurt = $EnemyHurt
@onready var animation_player = $AnimationPlayer

@export_enum("green", "purple") var slime_type: String
@export var direction: Direction = Direction.FORWARD

var injuring: bool = false

func _ready():
	animated_sprite.play("idle_" + slime_type)

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

func start_injured_animation():
	injuring = true
	animated_sprite.play("injure_" + slime_type)
	enemy_hurt.play()
	pass

func end_injured_animation():
	injuring = false
	animated_sprite.play("idle_" + slime_type)
	pass

func handle_damage():
	for target in entity.get_entered_attack_entities():
		if target.entity_type != EntityController.EntityType.PLAYER:
			return
		target.take_damage(entity.damage)

@warning_ignore("unused_parameter")
func on_injured(damage: float):
	if entity.is_died():
		return
	animation_player.play("on_injured")
	pass

func on_died():
	queue_free()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if injuring:
		return
	handle_direction()
	position.x += direction * entity.speed * delta;
	handle_damage()
