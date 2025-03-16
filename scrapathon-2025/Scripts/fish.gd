extends CharacterBody2D

var current_point: Vector2
var target_point: Vector2
var ttarget_point: Vector2
var total_time = 200
var percent_left: int
var difference: Vector2

var can_move = true

@export var decay_rate = 0.05
@export var speed = 200
@export var target_distance_min_max = Vector2(-1000,1000)
@export var timer_minmax = Vector2(0,5)

@onready var timer1 = $Timer1
@onready var combustion = preload("res://Scenes/combustion.tscn")

func _ready() -> void:
	check_target_point()

func _process(delta: float) -> void:
	evolve()
	animation_manager()

	if can_move:
		var direction = (target_point - current_point).normalized()
		velocity = (direction * speed)
		var temp_current_point = self.global_position
		difference = abs(Vector2(temp_current_point.x-target_point.x, temp_current_point.y-target_point.y))
		
		move_and_slide()
		
		if difference.x < 10 or difference.y < 10 :
			can_move = false
			var time = randi_range(timer_minmax.x, timer_minmax.y)
			timer1.start(time)
	
	percent_left = (Global.total_health/total_time)*100
	print(percent_left)
	
func check_target_point():
	var target_distance_xy: Vector2
	current_point = self.global_position
	
	target_distance_xy.x = randi_range(target_distance_min_max.x, target_distance_min_max.y)
	target_distance_xy.y = randi_range(target_distance_min_max.x, target_distance_min_max.y)
	ttarget_point = Vector2((current_point.x + target_distance_xy.x), (current_point.y + target_distance_xy.y))
	get_target_point()

func get_target_point():
	var ws = Global.window_size
	if ttarget_point.x < 0 or ttarget_point.x > ws.x or ttarget_point.y > ws.y or ttarget_point.y < 0:
		check_target_point()
	else:
		if ttarget_point.x > current_point.x:
			$Sprite2D.flip_h = false
		if ttarget_point.x < current_point.x:
			$Sprite2D.flip_h = true
		target_point = ttarget_point
		can_move = true

func evolve():
	Global.total_health -= decay_rate
	if Global.total_health <= 0:
		var combustion_effect = combustion.instantiate()
		get_tree().current_scene.add_child(combustion_effect)
		combustion_effect.global_position = self.global_position
		queue_free()


func animation_manager():
	if 80 < percent_left:
		$AnimationPlayer.play("Stage 1")
	if 60 < percent_left and percent_left <= 80:
		$AnimationPlayer.play("Stage 2")
	if 40 < percent_left and percent_left <= 60:
		$AnimationPlayer.play("Stage 3")
	if 20 < percent_left and percent_left <= 40:
		$AnimationPlayer.play("Stage 4")
	if 10 < percent_left and percent_left <= 20:
		$AnimationPlayer.play("Stage 5")
	if 0 < percent_left and percent_left <= 10:
		$AnimationPlayer.play("Stage 6")

func _on_timer_1_timeout() -> void:
	check_target_point()
	
	
