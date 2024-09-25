extends Node2D

@onready var _flavor_input_object : ItemList = $VBoxContainer/FlavorInput
@onready var _flavor_sprite : Sprite2D = $IceCream/Flavor
@onready var _sound_play : AudioStreamPlayer = $PlaySound
@onready var _sound_flavor : AudioStreamPlayer = $FlavorSound

func _ready() -> void:
	var _starting_flavor = randi_range(0, IceCream.flavor_info.size() - 1)
	IceCream.update_flavor(_starting_flavor)
	var _sprite_path : String = "res://ice_cream/flavor_"+IceCream.flavor_name()+".png"
	_flavor_sprite.set_texture(load(_sprite_path))


func _on_play_button_pressed() -> void:
	_sound_play.play()
	get_tree().change_scene_to_file("res://level/level.tscn")


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_float():
		Level.update_game_timer(new_text.to_float())


func _on_item_list_item_selected(index: int) -> void:
	_sound_flavor.play()
	IceCream.update_flavor(index)
	_flavor_sprite.set_texture(_flavor_input_object.get_item_icon(index))
	_flavor_input_object.remove_theme_color_override("font_selected_color")
	_flavor_input_object.add_theme_color_override("font_selected_color", IceCream.flavor_color())
