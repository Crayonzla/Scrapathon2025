extends Node

var window_size: Vector2i
@onready var food = preload("res://food.tscn")

func _ready() -> void:
	window_size = DisplayServer.screen_get_size()
	DisplayServer.window_set_size(window_size)
	get_window().mouse_passthrough = true

func _process(delta: float) -> void:
	get_window().always_on_top = true

func _on_timer_timeout() -> void:
	var food_spawn = food.instantiate()
	add_child(food_spawn)
	var random_posx = randi_range(0, window_size.x)
	var random_posy = randi_range(0, window_size.y)
	food_spawn.global_position = Vector2i(random_posx, random_posy)
	var food_sprite = food_spawn.get_node("Sprite2D")
	set_passthrough(food_sprite)
	$Timer.start()

func set_passthrough(sprite: Sprite2D):
	var texture_center: Vector2 = sprite.texture.get_size() / 2
	var texture_corners: PackedVector2Array = [
		sprite.global_position + texture_center * Vector2(-1, -1), # Top left corner
		sprite.global_position + texture_center * Vector2(1, -1), # Top right corner
		sprite.global_position + texture_center * Vector2(1 , 1), # Bottom right corner
		sprite.global_position + texture_center * Vector2(-1 ,1) # Bottom left corner
	]

	DisplayServer.window_set_mouse_passthrough(texture_corners)
