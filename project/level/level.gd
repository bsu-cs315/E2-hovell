class_name Level
extends Node2D

static var _wait_time : float

var _cone_regular : PackedScene = preload("res://cone/cone.tscn")
var _last_spawn_x : float = 0.0
var _spawn_pos : Vector2 = Vector2.ZERO

var _spawn_side : int
var _spawn_side_options : Array = [0.0, 0.0]

var _min_spawn_timer := 1.5
var _max_spawn_timer := 2.0
var _next_cone_secs : float

var _xmax := 650
var _xmin := 50
var _boundary_max := 280
var _boundary_min := 120
var _yspawn := -1000

@onready var _camera_object : Camera2D = $MainCamera
@onready var _cone_timer_object : Timer = $ConeSpawnTimer
@onready var _ice_cream_object : IceCream = $IceCream
@onready var _hud_object : Control = $Hud
@onready var _win_timer_object : Timer = $WinTimer

func _ready() -> void:
	if _wait_time > 5:
		_win_timer_object.wait_time = _wait_time
	_win_timer_object.start()
	
	_last_spawn_x = randf_range(_xmin, _xmax)
	var _starting_distance_between := 300
	var _startingy := -100
	for i in 5:
		_spawn_cone((i * _starting_distance_between)  + _startingy)
	
	
func _physics_process(_delta: float) -> void:
	_calculate_time_remaining()
	if _ice_cream_object.position.y > _camera_object.position.y + 700:
		_game_finished(false)
		
		
		
static func update_game_timer(new_time: float) -> void:
	_wait_time = new_time
		
		
func _game_finished(_is_win: bool) -> void:
	_cone_timer_object.stop()
	_camera_object.can_move = false
	_ice_cream_object.can_move = false
	_win_timer_object.stop()
	_hud_object.update_end_hud(_is_win, _camera_object.position)
	
		
func _calculate_time_remaining() -> void:
	var _time_left_percent : float = 100 - ((_win_timer_object.time_left / _win_timer_object.wait_time) * 100)
	var _new_position := Vector2(_camera_object.position.x - 350, _camera_object.position.y - 630)
	_hud_object.update_win_bar(_time_left_percent, _new_position)


func _spawn_cone(_ydistance) -> void:
	if _last_spawn_x > 550:
		_spawn_side = 0
		_spawn_side_options[0] = max (
			randf_range(_xmin, _last_spawn_x - _boundary_min),
			_xmin,
			_last_spawn_x - _boundary_max
			)
	elif _last_spawn_x < 150:
		_spawn_side = 1
		_spawn_side_options[1] = min (
			randf_range(_last_spawn_x + _boundary_min, _xmax),
			_xmax,
			_last_spawn_x + _boundary_max
			)
	else:
		_spawn_side = randi_range(0,1)
		_spawn_side_options[0] = max (
			randf_range(_xmin, _last_spawn_x - _boundary_min),
			_xmin,
			_last_spawn_x - _boundary_max
			)
			
		_spawn_side_options[1] = min (
			randf_range(_last_spawn_x + _boundary_min, _xmax),
			_xmax,
			_last_spawn_x + _boundary_max
			)
	_spawn_pos = Vector2(_spawn_side_options[_spawn_side], _ydistance)
	_last_spawn_x = _spawn_pos.x
	
	var _spawn : StaticBody2D = _cone_regular.instantiate()
	add_child(_spawn)
	_spawn.global_position = _spawn_pos
	
	
func _on_cone_spawn_timer_timeout() -> void:
	_spawn_cone(_camera_object.position.y + _yspawn)
	_restart_cone_timer()


func _on_start_timer_timeout() -> void:
	_spawn_cone(_camera_object.position.y + _yspawn)
	_restart_cone_timer()
	_hud_object.hide_tutorial()
	_camera_object.can_move = true


func _on_win_timer_timeout() -> void:
	_game_finished(true)
	
	
func _restart_cone_timer() -> void:
	_next_cone_secs = randf_range(_min_spawn_timer, _max_spawn_timer)
	_cone_timer_object.wait_time = _next_cone_secs
	_cone_timer_object.start() 
