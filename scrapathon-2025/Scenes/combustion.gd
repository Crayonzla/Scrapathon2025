extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("Combustion")
	$Timer.start()

func _on_timer_timeout() -> void:
	OS.shell_open("https://youtu.be/zKdnBIUq3W0?si=F5hLCnEsdDljz4z_")
	OS.shell_open("https://www.figma.com/proto/ikdWrth4jUPG8dnp5I2dZ0/goldy-site?node-id=1-1483&p=f&t=LtpWS7sPI3pBKVIe-0&scaling=min-zoom&content-scaling=fixed&page-id=1%3A3&starting-point-node-id=1%3A1483&hide-ui=1&show-proto-sidebar=1")
	get_tree().quit(-1)
