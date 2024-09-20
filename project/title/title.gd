extends Node2D

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level/level.tscn")


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_float():
		Level.update_game_timer(new_text.to_float())
