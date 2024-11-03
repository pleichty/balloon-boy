class_name Player

extends CharacterBody2D

@onready var hit_timer: Timer = $HitTimer
@export var balloonScene : PackedScene
var balloonRef : CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var balloons = 2
var balloonPumps = 0
var isPumping = false
var releasedBalloons = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func stopPumping() -> void:
	isPumping = false

func blowUpBalloons() -> void:
	if(balloons < 2):
		isPumping = true
		animated_sprite.play("pumping")
		if(balloonPumps < 6):
			balloonPumps += 1
		else:
			balloonPumps = 0
			if(balloons == 0):
				var tempBalloon = balloonScene.instantiate()
				add_child(tempBalloon) 
				balloonRef = tempBalloon
				tempBalloon.position = Vector2(0,-14)  
				tempBalloon.updateAnimation(1)
			else:
				balloonRef.updateAnimation(2)
			balloons += 1
	else:
		isPumping = false

func enemyHit() -> void:
	if(hit_timer.is_stopped()):	 
		animated_sprite.play("hit")
		hit_timer.start();
		balloons -= 1
		if(balloons == 1):
			balloonRef.updateAnimation(1) 
		elif(balloons == 0):
			balloonRef.updateAnimation(0)
			balloonRef.visible = false
			balloonRef = null
		else:
			GameManager.handlePlayerDeath()

func _ready() -> void:
	var tempBalloon = balloonScene.instantiate()
	var joint = PinJoint2D.new()
	add_child(tempBalloon)
	add_child(joint)
	joint.node_a = tempBalloon.get_path()
	balloonRef = tempBalloon
	tempBalloon.position = Vector2(0,-12)  
	
func attachBalloons(attached: CharacterBody2D, fullBalloons: bool) -> void:
	if not is_on_floor():
		get_tree().root.remove_child(attached)
		add_child(attached)  
		balloonRef = attached
		balloonRef.z_index = -1
		attached.position = Vector2(0,-12)  
		if(fullBalloons):
			balloons = 2
		else:
			balloons = 1
	
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
		
	# handle releasing balloons
	if Input.is_action_just_pressed("release") && balloons > 0:
		releasedBalloons = true
		balloons = 0
		
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
		
	if releasedBalloons:
		balloonRef.z_index = 5
		remove_child.call_deferred(balloonRef)
		get_tree().root.add_child.call_deferred(balloonRef)
		balloonRef.start(Vector2(position.x, position.y - 20))
		releasedBalloons = false
		balloonRef = null

	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	isPumping = false


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	GameManager.handlePlayerDeath()
