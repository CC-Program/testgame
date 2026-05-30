extends CharacterBody2D

@onready var invincible_timer = $InvincibleTimer
@onready var enemy_touched : CharacterBody2D = null

@export var max_health : float = 100.0
@export var health : float = 100.0
@export var current_exp : float = 0.0
@export var next_exp : float = 100.0
@export var move_speed : float = 200.0
@export var acceleration : float = 10.0
@export var friction : float = 15.0
@export var bullet_scene: PackedScene
@export var shoot_cooldown: float = 0.5

var invincible = false
var input_vector : Vector2 = Vector2.ZERO
var can_shoot := true
var last_facing := Vector2.DOWN
var touching_enemies := false

func get_health(): return health
func get_max_health(): return max_health

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
	
	#touching enemies
	if enemy_touched != null and not invincible:
		health -= enemy_touched.damage
		if health <=0:
			queue_free()
		invincible = true
		invincible_timer.start()

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

func exp_add(exp_get):
	current_exp += exp_get

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		enemy_touched = body

func _on_hurt_box_body_exited(body: Node2D) -> void:
	enemy_touched = null

func _on_invincible_timer_timeout() -> void:
	invincible = false
