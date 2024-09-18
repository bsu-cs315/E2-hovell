extends Node2D

signal game_finished

var _cone_regular : PackedScene = preload("res://cone/cone.tscn")
var _last_spawn_x : float = 0.0
var _spawn_pos : Vector2 = Vector2.ZERO

var _spawn_side : int
var _spawn_side_options : Array = [0.0, 0.0]

var _min_spawn_timer := 1.5
var _max_spawn_timer := 2.0
var next_cone_secs : float

@onready var _camera_object : Camera2D = $MainCamera
@onready var _cone_timer_object : Timer = $ConeSpawnTimer
@onready var _ice_cream_object : IceCream = $IceCream
@onready var _lose_label : Label = $Lose

func _ready() -> void:
	_last_spawn_x = randf_range(50, 650)
	for i in 5:
		_spawn_cone((i * 300) - 100)
	
	
func _physics_process(_delta: float) -> void:
	if _ice_cream_object.position.y > _camera_object.position.y + 700:
		_lose_label.position = _camera_object.position
		_lose_label.show()
		game_finished.emit()


func _spawn_cone(_ydistance) -> void:
	var _xmax := 650
	var _xmin := 50
	var _boundary_max := 290
	var _boundary_min := 120
	
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
	_spawn_cone(_camera_object.position.y - 1000)
	
	next_cone_secs = randf_range(_min_spawn_timer, _max_spawn_timer)
	_cone_timer_object.wait_time = next_cone_secs
	_cone_timer_object.start() 


func _on_start_timer_timeout() -> void:
	_spawn_cone(_camera_object.position.y - 1000)
	
	next_cone_secs = randf_range(_min_spawn_timer, _max_spawn_timer)
	_cone_timer_object.wait_time = next_cone_secs
	_cone_timer_object.start() 
	
	_camera_object.can_move = true
