extends Node

class_name Music

@export var common: AudioStreamPlayer2D
@export var death: AudioStreamPlayer2D

enum MusicType {
	COMMON,
	DEATH
}

func play_music(music: MusicType):
	if music == MusicType.COMMON:
		common.play()
		return
	if music == MusicType.DEATH:
		death.play()
		return
	print("Error Playing Music!!!")

func _ready():
	play_music(MusicType.COMMON)
