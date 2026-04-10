extends Node2D

@export var current_floor : TileMapLayer:
	set(value):
		if value == null:
			return
			
		if value.is_inside_tree():
			hide_layer()
			
		current_floor = value
		
		if value.is_inside_tree():
			show_layer()
			
		current_floor = value
		%Floor.text = value.name


func next_floor() -> void:
	if current_floor and "next" in current_floor:
		current_floor = current_floor.next

func prev_floor() -> void:
	if current_floor and "prev" in current_floor:
		current_floor = current_floor.prev
		
func show_layer() -> void:
	for area in current_floor.get_children():
		area.show()
		if area is not Area2D:
			continue
		area.set_deferred("monitoring", true)
	current_floor.set_deferred("enabled", true)
	
func hide_layer() -> void:
	for area in current_floor.get_children():
		area.hide()
		if area is not Area2D:
			continue
		area.set_deferred("monitoring", false)
	current_floor.set_deferred("enabled", false)
