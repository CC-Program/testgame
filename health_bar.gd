extends Node2D

@export var offset := Vector2(0, -40)

@onready var hp_label = $Label
var character_health = null

func _physics_process(delta: float) -> void:
	var target = get_parent()

	if target and target.has_method("get_health"):
		hp_label.text = str(target.get_health())
	position = offset
