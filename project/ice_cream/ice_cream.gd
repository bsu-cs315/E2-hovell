class_name IceCream
extends CharacterBody2D

const _SPEED : float = 300.0
const _JUMP_VELOCITY : float = -775.0
var can_move : bool = true
var _direction : int

func _physics_process(delta: float) -> void:
	if can_move:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_key_pressed(KEY_UP) and is_on_floor():
			velocity.y = _JUMP_VELOCITY

		if Input.is_key_pressed(KEY_LEFT):
			_direction = -1
		elif Input.is_key_pressed(KEY_RIGHT):
			_direction = 1
		else:
			_direction = 0
		
		if _direction:
			velocity.x = _direction * _SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, _SPEED)

		move_and_slide()
	
	
