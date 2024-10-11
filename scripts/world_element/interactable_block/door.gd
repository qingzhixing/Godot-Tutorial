extends Node2D

@export var door_open: bool = false

@export var target_scene: PackedScene

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var door_open_sfx: AudioStreamPlayer2D = $DoorOpen
@onready var door_close_sfx: AudioStreamPlayer2D = $DoorClose

var player_entered: bool = false

@warning_ignore("unused_parameter")
func _process(delta):
	if player_entered and Input.is_action_just_pressed("interact"):
		# 切换场景
		get_tree().change_scene_to_packed(target_scene)
	pass


@warning_ignore("unused_parameter")
func interact_body_enter(body: Node2D):
	player_entered = true
	if animated_sprite_2d.animation != "anim_open" and animated_sprite_2d.animation != "idle_open":
		animated_sprite_2d.play("anim_open")
		door_open_sfx.play()
		door_open = true

@warning_ignore("unused_parameter")
func interact_body_exit(body: Node2D):
	player_entered = false
	if animated_sprite_2d.animation != "anim_close" and animated_sprite_2d.animation != "idle_close":
		animated_sprite_2d.play("anim_close")
		door_close_sfx.play()
		door_open = false

func on_animated_sprite_animation_finished():
	if door_open:
		animated_sprite_2d.play("idle_open")
	else:
		animated_sprite_2d.play("idle_close")
