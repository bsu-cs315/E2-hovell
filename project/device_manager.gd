extends Node

signal finished_check

var _screen_size = DisplayServer.screen_get_size()
var is_mobile : bool

func _ready() -> void:
	await get_parent().ready
	if Input.get_accelerometer() == Vector3.ZERO:
		is_mobile = false
		get_window().size = Vector2i(540, 960)
		get_window().position.x = _screen_size.x / 2.0 - (get_window().size.x / 2.0)
		get_window().position.y = _screen_size.y / 2.0 - (get_window().size.y / 2.0)
	else:
		is_mobile = true
	finished_check.emit()
