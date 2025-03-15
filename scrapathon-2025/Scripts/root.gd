extends Node

var window_size: Vector2i

func _ready() -> void:
	window_size = DisplayServer.screen_get_size()
	DisplayServer.window_set_size(window_size)
	get_window().mouse_passthrough = true

func _process(delta: float) -> void:
	get_window().always_on_top = true
	
