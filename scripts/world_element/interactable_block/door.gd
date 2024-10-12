extends Node2D

@export var door_open: bool = false

@export var target_scene: PackedScene

@onready var animated_sprite_2d: AnimatedSprite2D = $"Animate Door"
@onready var animation_player: AnimationPlayer = $"Animation Player"
@onready var door_open_sfx: AudioStreamPlayer2D = $DoorOpen
@onready var label: Label = $Label
@onready var door_close_sfx: AudioStreamPlayer2D = $DoorClose

var player_entered: bool = false

@warning_ignore("unused_parameter")
func _process(delta):
	if player_entered and Input.is_action_just_pressed("interact"):
		# 切换场景
		get_tree().change_scene_to_packed(target_scene)
	if door_open:
		label.visible = true
	else:
		label.visible = false
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


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Animation finished: " + anim_name)
	animation_player.get_animation(anim_name).loop_mode = Animation.LOOP_PINGPONG
	animation_player.play(anim_name)
