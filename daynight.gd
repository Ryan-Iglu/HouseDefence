extends Node2D

@export var day_night_cycle: float = 10.0
@export var day_night_gradient: Gradient = preload("res://sun_gradient.tres")

var day_night_state: float = 0.0:
	set(value):
		day_night_state = value
		$CanvasModulate.color = day_night_gradient.sample(value)


func _on_timer_timeout() -> void:
	day_night_state += 1.0 / day_night_cycle * $Timer.wait_time
