extends CharacterBody2D

const SPEED = 100
var _direction : int
var _min_x := -6
var _max_x := 6
var _min_y := -5
var _max_y := 5

@onready var _ice_cream_body : IceCream = $".."

func _physics_process(_delta: float) -> void:
	if _ice_cream_body.can_move:
		if position.y > _max_y:
			position.y = _max_y
		if position.y < _min_y:
			position.y = _min_y

		if Input.is_action_pressed("jump") and not _ice_cream_body.is_on_floor():
			velocity.y = move_toward(velocity.y, _min_y, SPEED)
			
		elif not _ice_cream_body.is_on_floor():
			velocity.y = move_toward(velocity.y, _max_y, SPEED)
			
		else:
			position.y = move_toward(position.y, 0, SPEED)


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
