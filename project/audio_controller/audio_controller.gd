extends Node

@onready var _sounds : Array = [$Flavor, $Jump, $Land, $Play, $Restart]

func play_sound(index : int) -> void:
	_sounds[index].play()
