extends CharacterBody2D

const SPEED = 1500
@onready var timer: Timer = $Timer

var direction = 'horizontal'

func _physics_process(delta: float) -> void:
	if(direction == 'horizontal'):
		velocity.x = 1 * delta * SPEED 
		velocity.y = 0
	elif(direction == 'vertical'):
		velocity.y =  -1 * delta * SPEED
		velocity.x = 0
		
	move_and_slide()


func swapDirection(value) -> void:
	direction = value


func _on_timer_timeout() -> void:
	swapDirection('vertical')


func _on_timer_2_timeout() -> void:
	swapDirection('horizontal')
