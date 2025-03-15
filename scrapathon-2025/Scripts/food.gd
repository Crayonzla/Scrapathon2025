extends Area2D

var dragging = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
		elif !event.pressed:
			dragging = false

func _process(delta):
	if dragging:
		global_position = get_viewport().get_mouse_position()
