extends Camera2D

var _speed : int = 150

func _process(delta: float) -> void:
	var new_position = Vector2(0, (_speed * delta) * -1)
	position += new_position
