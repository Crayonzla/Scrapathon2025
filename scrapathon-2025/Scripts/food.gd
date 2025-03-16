extends Area2D

var dragging = false
var offset = Vector2.ZERO
var moving = false

@export var speed = 1000

func _process(delta):
	var mouse_position = get_global_mouse_position()
	var distance_to_mouse = global_position.distance_to(mouse_position) 
	if distance_to_mouse < 500 and moving == false:
		moving = true
	if moving:
		self.look_at(mouse_position)
		var direction = (mouse_position - global_position).normalized()
		global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	self.queue_free()
	Global.total_health += 50
