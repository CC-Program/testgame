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
	weapons[current_index].attack()

func next_weapon():
	current_index += 1
	if current_index >= weapons.size():
		current_index = 0
