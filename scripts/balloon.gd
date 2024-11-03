extends CharacterBody2D

class_name Balloons
@onready var balloons: Balloons = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var balloon_string: Area2D = $balloonString

var speed = 20;
var isFloating = false
var balloonCount = 2

# Called when the node enters the scene tree for the first time.
func start(pos):
	position = pos
	isFloating = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(isFloating):
		position.y -= speed * delta
		
func onHit() -> void:
	get_parent().enemyHit()

	
func updateAnimation(incomingBalloonCount: int) -> void:
	if(incomingBalloonCount == 2):
		animated_sprite_2d.play('double')
		balloonCount = 2
	elif(incomingBalloonCount == 1):
		animated_sprite_2d.play('single')
		balloonCount = 1
	else:
		balloons.visible = false
		balloonCount = 0


func _on_balloon_string_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if(body is Player):
		body.attachBalloons(self, balloonCount == 2)
		isFloating = false
