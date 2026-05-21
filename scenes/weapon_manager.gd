extends Node2D

var weapons = []
var current_index = 0

func add_weapon(weapon):
	weapons.append(weapon)

func remove_weapon(weapon):
	weapons.erase(weapon)

func attack():
	if weapons.is_empty():
		return
	weapons[current_index].attack()

func next_weapon():
	current_index += 1
	if current_index >= weapons.size():
		current_index = 0
