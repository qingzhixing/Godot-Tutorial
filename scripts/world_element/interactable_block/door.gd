extends Node2D

@export var door_open: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var door_open_sfx: AudioStreamPlayer2D = $DoorOpen
@onready var door_close_sfx: AudioStreamPlayer2D = $DoorClose


@warning_ignore("unused_parameter")
func interact_body_enter(body: Node2D):
	if animated_sprite_2d.animation != "anim_open" and animated_sprite_2d.animation != "idle_open":
		animated_sprite_2d.play("anim_open")
		# 刚打开门的瞬间就有声音
		door_open_sfx.play()
		door_open = true

@warning_ignore("unused_parameter")
func interact_body_exit(body: Node2D):
	if animated_sprite_2d.animation != "anim_close" and animated_sprite_2d.animation != "idle_close":
		animated_sprite_2d.play("anim_close")
		door_open = false

func on_animated_sprite_animation_finished():
	if door_open:
		animated_sprite_2d.play("idle_open")
	else:
		# 门在完全关闭时发出响声
		door_close_sfx.play()
		animated_sprite_2d.play("idle_close")
