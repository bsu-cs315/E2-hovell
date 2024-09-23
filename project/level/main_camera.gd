extends Camera2D

const SPEED_START : int = 150
var speed : int = 150
var can_move : bool = false

func _process(delta: float) -> void:
	if can_move:
		var new_position := Vector2(0, (speed * delta) * -1)
		position += new_position
