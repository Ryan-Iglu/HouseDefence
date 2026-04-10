extends character_entity

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * stats.movement_speed, delta * stats.acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, stats.friction * delta)
	move_and_slide()
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	print(body.get_damage())
	print("player has ", stats.health, " health")
	take_damage(body.get_damage())
	print("player has ", stats.health, " health remaining")
