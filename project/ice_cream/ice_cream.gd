class_name IceCream
extends CharacterBody2D

const _SPEED : float = 300.0
const _JUMP_VELOCITY : float = -775.0
var can_move : bool = true

func _physics_process(delta: float) -> void:
	if can_move:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = _JUMP_VELOCITY

		var direction := Input.get_axis("ui_left", "ui_right")
		
		if direction:
			velocity.x = direction * _SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, _SPEED)

		move_and_slide()
	
	
