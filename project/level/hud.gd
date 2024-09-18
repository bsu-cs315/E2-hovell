extends Control

@onready var _end_label : Label = $GameEndLabel
@onready var _win_bar : ColorRect = $GameWinBar
@onready var _restart_button : Button = $RestartButton

func _ready() -> void:
	_end_label.hide()
	_restart_button.hide()


func update_end_hud(is_win: bool, new_position: Vector2) -> void:
	_end_label.position.x = new_position.x - (_end_label.size.x / 2)
	_end_label.position.y = new_position.y
	
	_restart_button.position.x = new_position.x - (_restart_button.size.x / 2)
	_restart_button.position.y = new_position.y + 100
	
	if is_win:
		_end_label.text = "You Win!"
	else:
		_end_label.text = "You Lose!"
		_win_bar.hide()
	
	_end_label.show()
	_restart_button.show()
	
	
func update_win_bar(new_xsize: float, new_position: Vector2) -> void:
	_win_bar.size.x = new_xsize
	_win_bar.position = new_position


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
