extends Camera2D

const SPEED = 10
var direction = 'horizontal'
@onready var collision_shape_2d: CollisionShape2D = $RigidBody2D/CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(direction == 'horizontal'):
		position.x += 1 * delta * SPEED 
	elif(direction == 'vertical'):
		position.y -= 1 * delta * SPEED

func swapDirection(value) -> void:
	print('value', value)
	direction = value
