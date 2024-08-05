extends Node2D

const Direction = Constants.Direction
const EntityData = Classes.EntityData

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right_down = $RayCastRightDown
@onready var ray_cast_left_down = $RayCastLeftDown
@onready var animated_sprite = $AnimatedSprite2D
@onready var killzone = $Killzone

@export var speed = 20
@export var attack_interval = 0.6
var entity_data: EntityData = EntityData.construct(2, 1, 20)

@export var direction: Direction

func _ready():
	killzone.damage = entity_data.damage
	killzone.interval = attack_interval
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_direction()
	position.x += direction * entity_data.speed * delta;
