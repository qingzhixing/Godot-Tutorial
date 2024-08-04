extends CanvasLayer
@onready var animation_player = $AnimationPlayer

func flash_screen():
	animation_player.play("screen_flash")
	print('animation_player.play')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
