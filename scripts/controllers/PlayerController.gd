extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const EntityData = Classes.EntityData
const GameManager = preload("res://scripts/controllers/Game Manager.gd")

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D
@onready var hurt_audio = $Audios/Hurt
@onready var jump_audio = $"Audios/Jump"
@onready var game_manager = % "Game Manager" as GameManager

var entity_data: EntityData = EntityData.construct(5, 1, 130)
# @export var run_speed = 130.0
@export var jump_velocity = -320.0
var is_died = false
var injuring = false

func _ready():
	entity_data.on_died.connect(on_death)
	entity_data.on_injured.connect(on_injured)
	game_manager.set_heart_ui(entity_data.health)

func handle_sprite(direction: float):
	if is_died || injuring:
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

func on_injured(damage: float):
	print("Injured! damage: ", damage)
	hurt_audio.play()
	game_manager.handle_injury()
	game_manager.set_heart_ui(entity_data.health)
	animation_player.play("injure")

func start_injured_animation():
	if is_died:
		return
	injuring = true
	animated_sprite.play("injure")

func end_injured_animation():
	injuring = false

func on_death():
	print("You Died!")
	is_died = true
	animated_sprite.play("death")
	collision_shape.disabled = true
	game_manager.handle_death()

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		jump_audio.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	

	# Switch Animation
	handle_sprite(direction)

	# Movement
	if direction:
		velocity.x = direction * entity_data.speed
	else:
		velocity.x = move_toward(velocity.x, 0, entity_data.speed)

	move_and_slide()
