class_name IceCream
extends CharacterBody2D

const _SPEED := 300
const _JUMP_VELOCITY := -775.0

static var _flavor_index : int = 0
static var _flavor_chosen := false
static var flavor_info : Array = [
	["blueberry", "77ACD9"],
	["chocolate","635847"],
	["mint","9BD977"],
	["strawberry","E06FC7"],
	["vanilla","FFFFFF"]]

var can_move := true
var _direction : int
var _was_airborne := false
var _max_scale := 1.4
var _min_scale := 0.6

@onready var _jump_particle_object : CPUParticles2D = $JumpParticle
@onready var _body_part_sprites : Sprite2D = $IceCreamOutline
@onready var _flavor_object : Sprite2D = $IceCreamOutline/Flavor
	
func _ready() -> void:
	var _sprite_path : String = "res://ice_cream/flavor_"+flavor_name()+".png"
	_flavor_object.set_texture(load(_sprite_path))
	_jump_particle_object.color = flavor_color()


func _physics_process(delta: float) -> void:
	if can_move:
		if is_on_floor():
			if _was_airborne:
				_was_airborne = false
				_body_part_sprites.scale = Vector2(_max_scale, _min_scale)
				AudioController.play_sound(2)
		else:
			velocity += get_gravity() * delta
			_was_airborne = true

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = _JUMP_VELOCITY
			_jump_particle_object.emitting = true
			_body_part_sprites.scale = Vector2(_min_scale, _max_scale)
			AudioController.play_sound(1)
			
		if Input.is_action_pressed("move_left") or Input.get_accelerometer().x < -1.25:
			_direction = -1
			
		elif Input.is_action_pressed("move_right") or Input.get_accelerometer().x > 1.25:
			_direction = 1
			
		else:
			_direction = 0
		
		if _direction != 0:
			velocity.x = _direction * _SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, _SPEED)

		move_and_slide()
		
		_body_part_sprites.scale.x = move_toward(_body_part_sprites.scale.x, 1, 0.8 * delta)
		_body_part_sprites.scale.y = move_toward(_body_part_sprites.scale.y, 1, 0.8 * delta)
	

static func update_flavor(new_flavor : int) -> void:
	_flavor_index = new_flavor
	_flavor_chosen = true
	
static func flavor_name() -> String:
	return flavor_info[_flavor_index][0]

static func flavor_color() -> String:
	return flavor_info[_flavor_index][1]
