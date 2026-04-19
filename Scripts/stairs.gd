extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("next_floor"):
		get_tree().current_scene.next_floor()
	else:
		print("hello")
