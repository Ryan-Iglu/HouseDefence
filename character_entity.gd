extends CharacterBody2D	
class_name character_entity

@export var stats: Stats

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
	
	
func get_damage() -> float:
	return stats.damage
	
func take_damage(damage: float) -> void:
	print("player takes ", damage, " damage")
	stats.health = stats.health - damage
	if stats.health <= 0:
		queue_free()
	
	
	
