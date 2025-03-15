extends Node

var window_size = Vector2.ZERO
var total_health = 200

func _ready() -> void:
	window_size = DisplayServer.screen_get_size()
