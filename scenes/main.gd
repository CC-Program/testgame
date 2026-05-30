extends Node

@onready var player = $Player

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.enemy_died.connect(player.add_exp)
