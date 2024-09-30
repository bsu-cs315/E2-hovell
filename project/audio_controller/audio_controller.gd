extends Node

@onready var _sounds : Array = [$Select, $Jump, $Land]

func play_sound(index : int) -> void:
	_sounds[index].play()
