extends Control

@onready var _end_label : Label = $EndGameContainer/GameEndLabel
@onready var _win_bar : ColorRect = $GameWinBar
@onready var _end_container : VBoxContainer = $EndGameContainer
@onready var _background : ColorRect = $Background
@onready var _tutorial_container : VBoxContainer = $Tutorial
@onready var _win_particle_object : CPUParticles2D = $EndGameContainer/WinParticle

func _ready() -> void:
	_end_container.hide()
	_background.size = _tutorial_container.size
	_background.position = _tutorial_container.position
	_win_particle_object.emitting = false
	
	
func hide_tutorial() -> void:
	_tutorial_container.hide()
	_background.hide()


func update_end_hud(is_win: bool, new_position: Vector2) -> void:
	_end_container.position.x = new_position.x - (_end_container.size.x / 2)
	_end_container.position.y = new_position.y - (_end_container.size.y / 2)
	
	if is_win:
		_end_label.text = "You Win"
		_win_particle_object.emitting = true
	else:
		_end_label.text = "You Lose"
		_win_bar.hide()
	
	_end_container.show()
	
	
func update_win_bar(new_size: float, new_position: Vector2) -> void:
	_win_bar.size.y = new_size
	_win_bar.position = new_position


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://title/title.tscn")
