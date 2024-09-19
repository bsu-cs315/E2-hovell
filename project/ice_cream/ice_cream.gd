class_name IceCream
extends CharacterBody2D

const _SPEED : float = 300.0
const _JUMP_VELOCITY : float = -775.0
var can_move : bool = true
var _direction : int

@onready var _jump_particle_object : CPUParticles2D = $JumpParticle

func _physics_process(delta: float) -> void:
	if can_move:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = _JUMP_VELOCITY
			_jump_particle_object.emitting = true

		if Input.is_action_pressed("move_left"):
			_direction = -1
			
		elif Input.is_action_pressed("move_right"):
			_direction = 1
			
		else:
			_direction = 0
		
		if _direction:
			velocity.x = _direction * _SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, _SPEED)

		move_and_slide()
	
	
