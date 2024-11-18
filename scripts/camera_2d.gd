extends Camera2D

const SPEED = 0.0
@onready var camera_2d: Camera2D = $"."
var direction = 'horizontal'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(direction == 'horizontal'):
		camera_2d.position.x += 1 * SPEED 
	elif(direction == 'vertical'):
		camera_2d.position.y -= 1 * SPEED

func swapDirection(value) -> void:
	direction = value
