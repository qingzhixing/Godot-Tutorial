extends Node2D

class_name ArrowController

const Direction = _Direction.Direction

@onready var sprite_2d = $Sprite2D
@onready var entity = $EntityController
@onready var free_timer = $FreeTimer

@export var direction: Direction = Direction.FORWARD
@export var free_time: float = 3

func _ready():
	free_timer.one_shot = true
	free_timer.wait_time = free_time
	free_timer.start()

func destruct():
	entity.allow_attack = false
	queue_free()

func handle_attack():
	for targert in entity.get_entered_attack_entities():
		if targert.entity_type != _EntityType.EntityType.ENEMY:
			return
		if targert.take_damage(entity.damage):
			queue_free()
			return
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_2d.flip_h = (direction != Direction.FORWARD)
	position.x += entity.speed * direction * delta
	handle_attack()
