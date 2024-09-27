class_name Level
extends Node2D

static var _wait_time : float

var _cone_regular : PackedScene = preload("res://cone/cone.tscn")
var _last_spawn_x := 0.0
var _spawn_pos := Vector2.ZERO

var _spawn_side : int
var _spawn_side_options : Array = [0.0, 0.0]

var _MIN_SPAWN_TIMER_START := 1.5
var _MAX_SPAWN_TIMER_START := 2.0
var _min_spawn_timer := 1.5
var _max_spawn_timer := 2.0

var _xmax := 670
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
	#Input.emulate_touch_from_mouse = true
	#Input.emulate_mouse_from_touch = false
	
	if _wait_time > 5:
		_win_timer_object.wait_time = _wait_time
	_win_timer_object.start()
	
	_last_spawn_x = randf_range(_xmin, _xmax)
	var _starting_distance_between := 300
	var _startingy := -100
	for i in 5:
		_spawn_cone((i * _starting_distance_between)  + _startingy)
	
	
func _physics_process(_delta: float) -> void:
	var _win_bar_size_x := 500.0
	var _time_left_percent : float = _win_timer_object.time_left / _win_timer_object.wait_time
	
	if _ice_cream_object.position.y > _camera_object.position.y + 950:
		_game_finished(false)
	else:
		var _new_hud_size : float = _win_bar_size_x - (_time_left_percent * _win_bar_size_x)
		var _new_hud_position : = Vector2(_camera_object.position.x - 330, _camera_object.position.y + (_win_bar_size_x / 2))
		_hud_object.update_win_bar(_new_hud_size, _new_hud_position)
		_hud_object.update_controls_position(_new_hud_position)
		
		var _cam_speed_max_change := 75
		var _spawn_speed_max_change := 0.8
		
		_camera_object.speed = (_cam_speed_max_change * (1 - _time_left_percent )) + _camera_object.SPEED_START
		_min_spawn_timer = _MIN_SPAWN_TIMER_START - (_spawn_speed_max_change * (1 - _time_left_percent))
		_max_spawn_timer = _MAX_SPAWN_TIMER_START - (_spawn_speed_max_change * (1 - _time_left_percent))
		
		
static func update_game_timer(new_time: float) -> void:
	_wait_time = new_time
		
		
func _game_finished(_is_win: bool) -> void:
	_cone_timer_object.stop()
	_camera_object.can_move = false
	_ice_cream_object.can_move = false
	_win_timer_object.stop()
	_hud_object.update_end_hud(_is_win, _camera_object.position)


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
	_cone_timer_object.wait_time = randf_range(_min_spawn_timer, _max_spawn_timer)
	_cone_timer_object.start() 
