extends Camera2D

const SPEED = 0.5
@onready var camera_2d: Camera2D = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_2d.position.x += 1 * SPEED
