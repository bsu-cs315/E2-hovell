extends Camera2D

var _speed : int = 150
var can_move : bool = false

func _process(delta: float) -> void:
	if can_move:
		var new_position := Vector2(0, (_speed * delta) * -1)
		position += new_position


func _on_level_game_finished() -> void:
	can_move = false
