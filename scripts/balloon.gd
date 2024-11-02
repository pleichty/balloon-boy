extends Node2D

class_name Balloons
@onready var balloons: Balloons = $"."

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
	
func updateAnimation(balloonCount: int) -> void:
	if(balloonCount == 2):
		balloons.play('single')
		balloonCount == 2
	elif(balloonCount == 1):
		balloons.play('single')
		balloonCount = 1
	else:
		balloons.visible = false
		balloonCount = 0


func _on_balloon_string_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print('body.animation', balloons.animation)
	if(body is Player && isFloating):
		body.attachBalloons(self, balloons.animation == 'double')
		isFloating = false
