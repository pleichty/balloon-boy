extends CharacterBody2D

const SPEED = 1500

var direction = 'horizontal'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(direction == 'horizontal'):
		velocity.x = 1 * delta * SPEED 
	elif(direction == 'vertical'):
		velocity.y =  1 * delta * SPEED
		
	move_and_slide()


func swapDirection(value) -> void:
	print('value', value)
	direction = value
