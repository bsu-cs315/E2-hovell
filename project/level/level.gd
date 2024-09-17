extends Node2D

var _cone_regular : PackedScene = preload("res://cone/cone.tscn")
var _last_spawn_x : float = 0.0
var _spawn_pos : Vector2 = Vector2.ZERO

var randomSide : int
var randomSides : Array = [0.0, 0.0]

@onready var _camera_object : Camera2D = $MainCamera
@onready var _cone_timer_object : Timer = $ConeSpawnTimer

func _ready() -> void:
	_last_spawn_x = randf_range(50, 650)
	_spawn_cone()


func _spawn_cone() -> void:
	var _xmax = 650
	var _xmin = 50
	var _boundary_max = 290
	var _boundary_min = 120
	var _ydistance = 800
	
	if _last_spawn_x > 550:
		randomSides[0] = max(randf_range(_xmin, _last_spawn_x - _boundary_min), _xmin, _last_spawn_x - _boundary_max)
		randomSide = 0
		
	elif _last_spawn_x < 150:
		randomSides[1] = min(randf_range(_last_spawn_x + _boundary_min, _xmax), _xmax, _last_spawn_x + _boundary_max)
		randomSide = 1
		
	else:
		randomSides[0] = max(randf_range(_xmin, _last_spawn_x - _boundary_min), _xmin, _last_spawn_x - _boundary_max)
		randomSides[1] = min(randf_range(_last_spawn_x + _boundary_min, _xmax), _xmax, _last_spawn_x + _boundary_max)
		randomSide = randi_range(0,1)
	
	_spawn_pos = Vector2(randomSides[randomSide], _camera_object.position.y - _ydistance)
	_last_spawn_x = _spawn_pos.x
	
	var spawn : StaticBody2D = _cone_regular.instantiate()
	add_child(spawn)
	spawn.global_position = _spawn_pos
	
	var next_cone_secs : float = randf_range(1.5, 2.0)
	_cone_timer_object.wait_time = next_cone_secs
	$ConeSpawnTimer.start() 
	
	print ("Cone spawned at " + str(_spawn_pos.x) + ", " + str(_spawn_pos.y) +". Next one in " + str(next_cone_secs) + " secs")


func _on_cone_spawn_timer_timeout() -> void:
	_spawn_cone()
