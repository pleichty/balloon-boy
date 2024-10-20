extends CharacterBody2D

@onready var balloon_1: Sprite2D = %balloon1
@onready var balloon_2: Sprite2D = %balloon2

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var balloons = 2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func updateBalloonsVisibility() -> void:
	if(balloons == 2):
		balloon_1.visible = false
		balloon_2.visible = true
	if (balloons == 1):
		balloon_1.visible = true
		balloon_2.visible = false
	elif (balloons == 0):
		balloon_1.visible = false
		balloon_2.visible = false

func blowUpBalloons() -> void:
	if(balloons < 2):
		balloons += 1
	updateBalloonsVisibility()

func enemyHit() -> void:
	balloons -= 1
	updateBalloonsVisibility()
	if(balloons < 0):
		GameManager.handlePlayerDeath()


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():		
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite based on direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
		
	# Play animation
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

		
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
