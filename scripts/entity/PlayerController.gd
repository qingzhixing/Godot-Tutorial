extends CharacterBody2D

class_name PlayerController

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const EntityType = _EntityType.EntityType
const Direction = _Direction.Direction

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D
@onready var hurt_audio = $Audios/Hurt
@onready var jump_audio = $"Audios/Jump"
@onready var entity = $Entity
@onready var arrow_shooter = $ArrowShooter

@onready var game_manager = % "Game Manager" as GameManager

@export_category("player_data")
@export var jump_velocity: float = -320.0

@export_category("in_game_data")
@export var coin_amount: int = 0

var injuring = false

func _ready():
	game_manager.set_heart_ui(e ntity.health)
	game_manager.display_coin_amount(coin_amount)

func handle_sprite(direction: float):
	if entity.is_died() || injuring:
		return

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true;

	if !is_on_floor():
		animated_sprite.play("jump")
		return

	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")

func add_coin():
	coin_amount += 1
	game_manager.display_coin_amount(coin_amount)

func get_direction() -> Direction:
	if animated_sprite.flip_h:
		return Direction.BACKWARD
	
	return Direction.FORWARD

func on_injured(damage: float):
	print("Injured! damage: ", damage)
	hurt_audio.play()
	game_manager.handle_injury()
	game_manager.set_heart_ui(entity.health)
	animation_player.play("injure")

func start_injured_animation():
	if entity.is_died():
		return
	injuring = true
	animated_sprite.play("injure")

func end_injured_animation():
	injuring = false

func on_died():
	print("You Died!")
	animated_sprite.play("death")
	collision_shape.disabled = true
	game_manager.handle_death()

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		jump_audio.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("shoot"):
		arrow_shooter.shoot(get_direction())

	# Switch Animation
	handle_sprite(direction)

	# Movement
	if direction:
		velocity.x = direction * entity.speed
	else:
		velocity.x = move_toward(velocity.x, 0, entity.speed)

	move_and_slide()

func handle_attack():
	for target in entity.get_entered_attack_entities():
		if target.entity_type != EntityType.ENEMY:
			return
		target.take_damage(entity.damage)

@warning_ignore("unused_parameter")
func _process(delta):
	handle_attack()
