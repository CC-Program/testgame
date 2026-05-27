extends Node2D

@export var offset := Vector2(0, -40)

@onready var exp_label = $Label
@onready var exp_bar = $ProgressBar

func _ready() -> void:
	exp_bar.max_value = get_parent().get_next_level_exp()
	position = offset

func _physics_process(delta: float) -> void:
	var target = get_parent()

	if target and target.has_method("get_health"):
		hp_label.text = str(target.get_max_health())+"/"+str(target.get_health())
		hp_bar.value = target.get_health()
