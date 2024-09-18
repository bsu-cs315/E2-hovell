extends Control

@onready var _end_label : Label = $GameEndLabel
@onready var _win_bar : ColorRect = $GameWinBar

func update_end_label(new_text: String, new_position: Vector2) -> void:
	_end_label.position = new_position
	_end_label.text = new_text
	_end_label.show()
	
	
func update_win_bar(new_xsize: float, new_position: Vector2) -> void:
	_win_bar.size.x = new_xsize
	_win_bar.position = new_position
