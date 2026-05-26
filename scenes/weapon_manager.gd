extends Node2D

@onready var weapon_full_list = get_children()
var weapon_got = []
var current_weapon = 0

func _ready() -> void:
	weapon_got.append(weapon_full_list)

func add_weapon(weapon):
	if not weapon_got.has(weapon):
		weapon_got.append(weapon)

func remove_weapon(weapon):
	if weapon_got.has(weapon):
		weapon_got.erase(weapon)

func attack():
	if weapon_got.is_empty():
		return
	weapon_got[current_weapon].attack()

func next_weapon():
	current_weapon += 1
	if current_weapon >= weapon_got.size():
		current_weapon = 0
