extends CharacterBody2D

enum EnemyType {
	PATROL,
	CHASE
}

@export var enemy_type : EnemyType = EnemyType.CHASE

@export var move_speed : float = 100.0

# Patrol settings
@export var point_a : Vector2
@export var point_b : Vector2

var patrol_target : Vector2

var player = null

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
		return

	var dir = (player.global_position - global_position).normalized()

	velocity = dir * move_speed


func die():
	queue_free()
