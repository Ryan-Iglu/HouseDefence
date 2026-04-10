extends character_entity


@export var target: character_entity


func _ready() -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	if target == null or stats == null:
		return
	var direction = (target.global_position - global_position).normalized()
	velocity = direction * stats.movement_speed
	move_and_slide()
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
