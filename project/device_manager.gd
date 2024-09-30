extends Node

signal finished_process

var _screen_size = DisplayServer.screen_get_size()
var is_mobile : bool
var finished_check := false

func _process(_delta: float) -> void:
	if not finished_check:
		finished_check = true
		if Input.get_accelerometer() == Vector3.ZERO:
			is_mobile = false
			get_window().size = Vector2i(540, 960)
			get_window().position.x = _screen_size.x / 2.0 - (get_window().size.x / 2.0)
			get_window().position.y = _screen_size.y / 2.0 - (get_window().size.y / 2.0)
		else:
			is_mobile = true
		finished_process.emit()
