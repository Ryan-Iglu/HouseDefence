extends character_entity

var is_on_stairs: bool = false
var stairs_climb_dir: float = 0.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var ammo: PackedScene = preload("res://Scenes/bullet.tscn")
@export var marker_2d: Marker2D

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	look_at(get_global_mouse_position())
	if direction != Vector2.ZERO:
		anim.play("walk")
		
		#look_at(global_position + direction)
		#rotation += deg_to_rad(90)
		velocity = velocity.move_toward(direction * stats.movement_speed, delta * stats.acceleration)
	else:
		anim.play("idle")
		velocity = velocity.move_toward(Vector2.ZERO, stats.friction * delta)
	
	if is_on_stairs and direction != Vector2.ZERO:
		var forward_input = direction.y
		if abs(forward_input) > 0.3:
			stairs_climb_dir = sign(forward_input)
			velocity.y += stairs_climb_dir * 60.0
			velocity.x *= 0
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	move_and_slide()
	
	if is_on_stairs:
		z_index = 1 if velocity.y < 0 else 0
		
func enter_stairs() -> void:
	is_on_stairs = true
	
func exit_stairs() -> void:
	is_on_stairs = false
	stairs_climb_dir = 0.0
	

func shoot() -> void:
	if not ammo:
		push_error("player has no ammo selected")
		return
	anim.play("shoot")
	var bullet = ammo.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	var mouse_dir = (get_global_mouse_position() - global_position).normalized()
	
	if bullet.has_method("set_direction"):
		bullet.set_direction(mouse_dir)
	else:
		bullet.direction = mouse_dir
		

func _on_hitbox_body_entered(body: Node2D) -> void:
	print(body.get_damage())
	print("player has ", stats.health, " health")
	take_damage(body.get_damage())
	print("player has ", stats.health, " health remaining")
