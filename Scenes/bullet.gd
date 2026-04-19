extends Node2D

@export var speed: float = 100.0
@export var lifetime: float = 2.0
@export var damage: float = 10.0

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	top_level = true
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func set_direction(new_dir: Vector2) -> void:
	direction = new_dir.normalized()
	rotation = new_dir.angle()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and body.is_in_group("Enemy"):
		body.take_damage(damage)
		queue_free()
