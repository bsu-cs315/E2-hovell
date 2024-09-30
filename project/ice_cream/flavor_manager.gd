extends Node

var _flavor_index : int = 0
var _flavor_info : Array = [
	["blueberry", "77ACD9"],
	["chocolate","635847"],
	["mint","9BD977"],
	["strawberry","E06FC7"],
	["vanilla","FFFFFF"]]
	
func _ready() -> void:
	var _starting_flavor = randi_range(0, _flavor_info.size() - 1)
	update_flavor(_starting_flavor)

func update_flavor(new_flavor : int) -> void:
	_flavor_index = new_flavor
	
func flavor_name() -> String:
	return _flavor_info[_flavor_index][0]

func flavor_color() -> String:
	return _flavor_info[_flavor_index][1]
