extends CanvasLayer
@onready var screen_flash = $ScreenFlash

func set_screen_flash_transparent(transparent:float):
		screen_flash.modulate.a = transparent

# Called when the node enters the scene tree for the first time.
func _ready():
	set_screen_flash_transparent(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
