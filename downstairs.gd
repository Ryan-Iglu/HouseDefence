extends Area2D


func _on_body_entered(body: Node2D) -> void:
	get_tree().current_scene.prev_floor()
