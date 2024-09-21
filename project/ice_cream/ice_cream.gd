class_name IceCream
extends CharacterBody2D

const _SPEED : float = 300.0
const _JUMP_VELOCITY : float = -775.0
var can_move : bool = true
var _direction : int

var was_airborne := false

@onready var _jump_particle_object : CPUParticles2D = $JumpParticle

func _physics_process(delta: float) -> void:
	if can_move:
		if is_on_floor():
			if was_airborne:
				was_airborne = false
				$IceCreamBody.scale = Vector2(1.3, 0.7)
				$IceCreamEyeRight/EyeRight.scale = Vector2(1.3, 0.7)
				$IceCreamEyeLeft/EyeLeft.scale = Vector2(1.3, 0.7)
		else:
			velocity += get_gravity() * delta
			was_airborne = true

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = _JUMP_VELOCITY
			_jump_particle_object.emitting = true
			$IceCreamBody.scale = Vector2(0.7, 1.3)
			$IceCreamEyeRight/EyeRight.scale = Vector2(0.7, 1.3)
			$IceCreamEyeLeft/EyeLeft.scale = Vector2(0.7, 1.3)

		if Input.is_action_pressed("move_left"):
			_direction = -1
			
		elif Input.is_action_pressed("move_right"):
			_direction = 1
			
		else:
			_direction = 0
		
		if _direction != 0:
			velocity.x = _direction * _SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, _SPEED)

		move_and_slide()
		$IceCreamBody.scale.x = move_toward($IceCreamBody.scale.x, 1, delta)
		$IceCreamBody.scale.y = move_toward($IceCreamBody.scale.y, 1, delta)
		
		$IceCreamEyeRight/EyeRight.scale.x = move_toward($IceCreamEyeRight/EyeRight.scale.x, 1, delta)
		$IceCreamEyeRight/EyeRight.scale.y = move_toward($IceCreamEyeRight/EyeRight.scale.y, 1, delta)
	
		$IceCreamEyeLeft/EyeLeft.scale.x = move_toward($IceCreamEyeLeft/EyeLeft.scale.x, 1, delta)
		$IceCreamEyeLeft/EyeLeft.scale.y = move_toward($IceCreamEyeLeft/EyeLeft.scale.y, 1, delta)
	
