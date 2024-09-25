extends CharacterBody2D

const SPEED = 100
var _direction : int
var _min_x := -6
var _max_x := 6
var _min_y := -5
var _max_y := 5

@onready var _ice_cream_body : IceCream = $"../.."
@onready var _face_object : Sprite2D = $Mouth
@onready var _face_sprites : Array = [
	load("res://ice_cream/mouth_smile.png"),
	load("res://ice_cream/mouth_open.png")]

func _physics_process(_delta: float) -> void:
	if _ice_cream_body.can_move:
		position.y = clamp(position.y, _min_y, _max_y)
		_face_object.set_texture(_face_sprites[1])

		if Input.is_action_pressed("jump") and not _ice_cream_body.is_on_floor():
			velocity.y = move_toward(velocity.y, _min_y, SPEED)
			
		elif not _ice_cream_body.is_on_floor():
			velocity.y = move_toward(velocity.y, _max_y, SPEED)
			
		else:
			position.y = move_toward(position.y, 0, SPEED)
			_face_object.set_texture(_face_sprites[0])


		if Input.is_action_pressed("move_left") and position.x > _min_x:
			_direction = -1
			
		elif Input.is_action_pressed("move_right") and position.x < _max_x:
			_direction = 1
			
		else:
			_direction = 0
			
		if _direction != 0:
			velocity.x = _direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
