extends CharacterBody2D

@export var move_speed : float = 200.0
@export var acceleration : float = 10.0
@export var friction : float = 15.0
@export var bullet_scene: PackedScene
@export var shoot_cooldown: float = 0.5

var input_vector : Vector2 = Vector2.ZERO
var can_shoot := true
var last_facing := Vector2.DOWN

func _physics_process(delta):

	# Get input
	input_vector = Vector2(
		Input.get_action_strength("player_right") - Input.get_action_strength("player_left"),
		Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	).normalized()

	# Movement
	if input_vector != Vector2.ZERO:
		velocity = velocity.lerp(input_vector * move_speed, acceleration * delta)
		last_facing = input_vector
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
	
	#Shoot
	if Input.is_action_pressed("player_attack_confirm") and can_shoot:
		shoot()
	
	if input_vector != Vector2.ZERO:
		last_facing = input_vector

	move_and_slide()

func shoot():
	can_shoot = false
	var bullet = bullet_scene.instantiate()

	# Spawn position (in front of player slightly)
	bullet.global_position = global_position + input_vector.normalized() * 10

	# If no movement input, shoot last facing direction fallback
	var dir = last_facing
	if dir == Vector2.ZERO:
		dir = Vector2.RIGHT  # default direction

	bullet.direction = dir.normalized()

	get_tree().current_scene.add_child(bullet)

	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
