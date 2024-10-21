extends AnimatableBody2D

var isFalling = false;
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var player_entered: Area2D = $player_entered

func _physics_process(delta: float) -> void:
	if isFalling:		
		sprite_2d.position.y += 3
		collision_shape_2d.position.y += 3

func _on_timer_timeout() -> void:
	isFalling = true

func _on_player_entered_body_entered(body: Node2D) -> void:
	if(body is Player && body.is_on_floor()):
		timer.start()
