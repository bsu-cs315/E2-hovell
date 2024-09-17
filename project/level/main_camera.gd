extends Camera2D

var _speed : int = 150
var _can_move : bool = true

func _process(delta: float) -> void:
	if _can_move:
		var new_position := Vector2(0, (_speed * delta) * -1)
		position += new_position


func _on_level_game_finished() -> void:
	_can_move = false
