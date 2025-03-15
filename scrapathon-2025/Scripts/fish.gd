extends CharacterBody2D

var current_point: Vector2
var target_point: Vector2
var ttarget_point: Vector2
var can_move = false

@export var speed = 200
@export var target_distance_min_max = Vector2(-10,10)

@onready var timer1 = $Timer1

func _ready() -> void:
	timer1.start()
	check_target_point()

func _process(delta: float) -> void:
	current_point = self.position
	if can_move:
		var direction = (target_point-current_point).normalized()
		velocity = (direction * speed)
	
	if target_point == current_point:
		can_move = false
	
	move_and_slide()

func check_target_point():
	var target_distance_xy: Vector2
	target_distance_xy.x = randi_range(target_distance_min_max.x, target_distance_min_max.y)
	target_distance_xy.y = randi_range(target_distance_min_max.x, target_distance_min_max.y)
	ttarget_point = Vector2((current_point.x + target_distance_xy.x), (current_point.y + target_distance_xy.y))
	get_target_point()

func get_target_point():
	var ws = Global.window_size
	print(ttarget_point)
	if ttarget_point.x < 0 or ttarget_point.x > ws.x or ttarget_point.y > ws.y or ttarget_point.y < 0:
		check_target_point()
	else:
		target_point = ttarget_point
