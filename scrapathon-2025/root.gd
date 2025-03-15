extends Node

var window_size: Vector2i

func _ready() -> void:
	window_size = DisplayServer.screen_get_size()
	DisplayServer.window_set_size(window_size)
	get_viewport().transparent_bg = true
