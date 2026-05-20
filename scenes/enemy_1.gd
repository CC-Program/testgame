extends CharacterBody2D

enum EnemyType {
	PATROL,
	CHASE
}

@export var health : float = 100.0
@export var damage : float = 50.0
@export var enemy_type : EnemyType = EnemyType.CHASE
@export var move_speed : float = 100.0

# Patrol settings
@export var point_a : Vector2
@export var point_b : Vector2

var patrol_target : Vector2
var player = null

func get_health(): return health

func _ready():
	patrol_target = point_b
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	match enemy_type:
		EnemyType.PATROL:
			patrol_behavior()
		EnemyType.CHASE:
			chase_behavior()
	move_and_slide()

func patrol_behavior():
	var dir = (patrol_target - global_position).normalized()
	velocity = dir * move_speed
	if global_position.distance_to(patrol_target) < 5:
		if patrol_target == point_a:
			patrol_target = point_b
		else:
			patrol_target = point_a

func chase_behavior():
	if player == null:
		velocity = Vector2.ZERO
	else:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * move_speed

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		area.queue_free()
		health -=area.damage
		if health <= 0:
			queue_free()
