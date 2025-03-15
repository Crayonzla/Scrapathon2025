extends Node

var window_size: Vector2i

func _ready() -> void:
	window_size = DisplayServer.screen_get_size()
	DisplayServer.window_set_size(window_size)
	get_window().mouse_passthrough = true
	var window = get_window()
	window.mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	await get_tree().process_frame
	window.mode = Window.MODE_WINDOWED
	window.always_on_top = true

func _process(delta: float) -> void:
	get_window().always_on_top = true
