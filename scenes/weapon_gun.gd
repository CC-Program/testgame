extends Node2D

var can_shoot := true
@export var bullet_scene: PackedScene
@export var shoot_cooldown: float = 0.5

const WEAPON_NAME = "Gun"

func attack(input_vector):
	can_shoot = false
	var bullet = bullet_scene.instantiate()

	# Spawn position (in front of player slightly)
	bullet.global_position = global_position + input_vector.normalized() * 10

	get_tree().current_scene.add_child(bullet)

	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true

func get_weapon_name():
	return(WEAPON_NAME)
