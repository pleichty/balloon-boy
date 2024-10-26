class_name Player

extends CharacterBody2D

@onready var hit_timer: Timer = $HitTimer
@export var balloonScene : PackedScene
var balloonsArr : Array[Sprite2D]

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var balloons = 2
var balloonPumps = 0
var isPumping = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func stopPumping() -> void:
	isPumping = false

func updateBalloonsVisibility() -> void:
	if(balloons == 2):
		balloonsArr[0].visible = false
		balloonsArr[1].visible = true
	if (balloons == 1):
		balloonsArr[0].visible = true
		balloonsArr[1].visible = false
	elif (balloons == 0):
		balloonsArr[0].visible = false
		balloonsArr[1].visible = false

func blowUpBalloons() -> void:
	if(balloons < 2):
		isPumping = true
		animated_sprite.play("pumping")
		if(balloonPumps < 6):
			balloonPumps += 1
		else:
			balloonPumps = 0
			balloons += 1
	else:
		isPumping = false
	updateBalloonsVisibility()

func enemyHit() -> void:
	if(hit_timer.is_stopped()):	
		animated_sprite.play("hit")
		hit_timer.start();
		balloons -= 1
		updateBalloonsVisibility()
		if(balloons < 0):
			GameManager.handlePlayerDeath()

func _ready() -> void:
	var tempBalloon = balloonScene.instantiate()
	var tempBalloon2 = balloonScene.instantiate()
	add_child.call_deferred(tempBalloon) 
	add_child.call_deferred(tempBalloon2)
	balloonsArr.append(tempBalloon)
	balloonsArr.append(tempBalloon2)
	tempBalloon.position = Vector2(4,-8)
	tempBalloon2.position = Vector2(0 , -8)  

	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():		
		if(balloons > 0):
			velocity += get_gravity() * delta * .5
		else:
			velocity += get_gravity() * delta
		
	if(isPumping):
		move_and_slide()
		return;
	# Handle jump.
	if Input.is_action_just_pressed("jump") && balloons > 0:
		velocity.y = JUMP_VELOCITY * .5
	elif Input.is_action_just_pressed("jump") && balloons == 0 && is_on_floor():
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
	if (!hit_timer.is_stopped()):
		animated_sprite.play("hit")
	elif is_on_floor():
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

func _on_animated_sprite_2d_animation_finished() -> void:
	isPumping = false


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	GameManager.handlePlayerDeath()
