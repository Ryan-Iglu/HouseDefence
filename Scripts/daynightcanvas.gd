extends CanvasModulate
class_name DayAndNightCycle

signal change_day_time(day_time: DayState)

enum DayState { NIGHT, SUNRISE, MORNING, NOON, AFTERNOON, SUNSET, EVENING }

@export var time_label: Label

# How long one full in-game day lasts in real time
@export var day_length_minutes: float = 10.0

# Drag a Gradient resource here in the inspector (very easy to edit!)
@export var day_night_gradient: Gradient

var current_day_state: DayState = DayState.NIGHT
var _total_time: float = 0.0
var _last_hour: int = -1

const SECONDS_PER_DAY: float = 86400.0

func _ready() -> void:
	add_to_group("dayAndNightCycle")
	# Start at 6 AM (sunrise)
	_total_time = 6 * 3600


func _process(delta: float) -> void:
	# Advance time (faster or slower depending on day_length_minutes)
	_total_time += delta * (SECONDS_PER_DAY / (day_length_minutes * 60.0))
	
	var cycle_progress = fmod(_total_time, SECONDS_PER_DAY) / SECONDS_PER_DAY  # 0.0 → 1.0

	_update_color(cycle_progress)
	_update_time_label(cycle_progress)
	_update_day_state(cycle_progress)


func _update_color(cycle_progress: float) -> void:
	if day_night_gradient:
		self.color = day_night_gradient.sample(cycle_progress)


func _update_time_label(cycle_progress: float) -> void:
	if not time_label:
		return
	
	var current_hour := int(cycle_progress * 24)
	if current_hour != _last_hour:
		var minutes := int(fmod(cycle_progress * 1440, 60))
		time_label.text = "Time: %02d:%02d" % [current_hour, minutes]
		_last_hour = current_hour


func _update_day_state(cycle_progress: float) -> void:
	var hour := cycle_progress * 24.0
	var new_state: DayState = DayState.NIGHT
	
	if hour < 5.0 or hour >= 21.0:
		new_state = DayState.NIGHT
	elif hour < 7.0:
		new_state = DayState.SUNRISE
	elif hour < 10.0:
		new_state = DayState.MORNING
	elif hour < 16.0:
		new_state = DayState.NOON
	elif hour < 18.0:
		new_state = DayState.AFTERNOON
	elif hour < 20.0:
		new_state = DayState.SUNSET
	else:
		new_state = DayState.EVENING
	
	if new_state != current_day_state:
		current_day_state = new_state
		change_day_time.emit(current_day_state)

'''
extends CanvasModulate
class_name DayAndNightCycle

signal change_day_time(day_time: DayState)

@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum DayState{NOON, EVENING}

var day_time: DayState = DayState.NOON
var cycle_time: float = 0.0
var _last_hour: int = -1
@export var time: Label
	
		

func _ready() -> void:
	add_to_group("dayAndNightCycle")
	if animation_player:
		animation_player.play("daynight")
		animation_player.seek(0.0, true)
	
func _process(delta: float) -> void:
	if not animation_player or not animation_player.is_playing():
		return
	var animation_pos = animation_player.current_animation_position
	var animation_length = animation_player.current_animation_length / 2
	var cycle_progress = fmod(animation_pos, animation_length) / animation_length
	
	_update_time_label(cycle_progress)
	_update_day_state(animation_pos, animation_length)
	
		
	
	
		
func _update_time_label(cycle_progress: float) -> void:
	if not time:
		return
	var current_hour = int(cycle_progress * 24)
	if current_hour != _last_hour:
		var minutes = int(fmod(cycle_progress * 1440, 60))
		time.text = "Time: %02d:%02d" % [current_hour, minutes]
		_last_hour = current_hour
		
func _update_day_state(pos: float, length: float) -> void:
	var half_length = length / 2.0
	if pos > half_length and day_time != DayState.EVENING:
		day_time = DayState.EVENING
		change_day_time.emit(day_time)
	elif pos < half_length and day_time != DayState.NOON:
		day_time = DayState.NOON
		change_day_time.emit(day_time)
'''
