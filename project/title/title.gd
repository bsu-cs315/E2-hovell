extends Node2D

static var check_complete = false;

var screen_size = DisplayServer.screen_get_size()
var window = get_window()

@onready var _flavor_input_object : ItemList = $VBoxContainer/FlavorInput
@onready var _resolution_input_object : ItemList = $VBoxContainer/ResolutionInput
@onready var _flavor_sprite : Sprite2D = $IceCream/Flavor

func _ready() -> void:
	var _starting_flavor_sprite : String = "res://ice_cream/flavor_"+FlavorManager.flavor_name()+".png"
	_flavor_sprite.set_texture(load(_starting_flavor_sprite))
	
	
func _process(_delta: float) -> void:
	if not check_complete:
		check_complete = true
		if Input.get_accelerometer() == Vector3.ZERO: # Desktop
			get_window().size = Vector2i(540, 960)
			get_window().position.x = screen_size.x / 2.0 - (get_window().size.x / 2.0)
			get_window().position.y = screen_size.y / 2.0 - (get_window().size.y / 2.0)
		else: # Mobile
			_resolution_input_object.hide()


func _on_play_button_pressed() -> void:
	AudioController.play_sound(3)
	get_tree().change_scene_to_file("res://level/level.tscn")


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_float():
		Level.update_game_timer(new_text.to_float())


func _on_flavor_input_item_selected(index: int) -> void:
	AudioController.play_sound(0)
	FlavorManager.update_flavor(index)
	_flavor_sprite.set_texture(_flavor_input_object.get_item_icon(index))
	_flavor_input_object.remove_theme_color_override("font_selected_color")
	_flavor_input_object.add_theme_color_override("font_selected_color", FlavorManager.flavor_color())


func _on_resolution_input_item_selected(index: int) -> void:
	if index == 0:
		get_window().size = Vector2i(360, 640)
	elif index == 1:
		get_window().size = Vector2i(480, 854)
	elif index == 2:
		get_window().size = Vector2i(540, 960)
	elif index == 3:
		get_window().size = Vector2i(576, 1024)
	elif index == 4:
		get_window().size = Vector2i(720, 1280)
	
	get_window().position.x = screen_size.x / 2.0 - (get_window().size.x / 2.0)
	get_window().position.y = screen_size.y / 2.0 - (get_window().size.y / 2.0)
