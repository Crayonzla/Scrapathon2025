extends Node

var window_size = Vector2.ZERO

func _ready() -> void:
	window_size = DisplayServer.screen_get_size()
