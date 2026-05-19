extends Area2D

@export var speed: float = 500.0
@export var range: float = 400.0
@export var damage: float = 50.0

var direction: Vector2 = Vector2.ZERO
var start_position: Vector2

func _ready():
	start_position = global_position

func _physics_process(delta):
	# Move bullet
	global_position += direction * speed * delta
	# Check range limit
	if global_position.distance_to(start_position) > range:
		queue_free()
