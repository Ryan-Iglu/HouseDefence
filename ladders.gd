extends Node2D

const TEST_LEVEL = preload("res://Scenes/test_level.tscn")
@export var climb_speed: float = 80.0

var bodies_on_stairs: Array[Node2D] = []


func _on_stair_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.has_method("enter_stairs"):
		get_tree().change_scene_to_file("res://Scenes/test_level.tscn")
		#bodies_on_stairs.append(body)
		#body.enter_stairs()


func _on_stair_hitbox_body_exited(body: Node2D) -> void:
	if body in bodies_on_stairs and body.has_method("exit_stairs"):
		bodies_on_stairs.erase(body)
		body.exit_stairs()
