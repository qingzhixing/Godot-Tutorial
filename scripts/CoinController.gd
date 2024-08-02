extends Area2D


func _on_body_entered(body):
	print("Coin +1!")
	print(body.name)
	queue_free()
