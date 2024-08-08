extends Area2D
const Direction = Constants.Direction

@onready var sprite_2d = $Sprite2D

@export var fly_speed: int = 10
@export var direction: Direction = Direction.FORWARD

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == Direction.FORWARD:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true
	position.x += fly_speed * direction * delta
