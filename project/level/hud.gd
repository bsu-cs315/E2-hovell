extends Control

@onready var _end_label : Label = $GameEndLabel
@onready var _win_bar : ColorRect = $GameWinBar

func update_end_hud(is_win: bool, new_position: Vector2) -> void:
	_end_label.position = new_position
	
	if is_win:
		_end_label.text = "You Win!"
	else:
		_end_label.text = "You Lose!"
		_win_bar.hide()
	
	_end_label.show()
	
	
func update_win_bar(new_xsize: float, new_position: Vector2) -> void:
	_win_bar.size.x = new_xsize
	_win_bar.position = new_position
