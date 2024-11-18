extends AnimatableBody2D

var isFalling = false;
@onready var timer: Timer = $Timer
@onready var player_entered: Area2D = $player_entered

func _physics_process(_delta: float) -> void:
	if isFalling:		
		position.y += 3

func _on_timer_timeout() -> void:
	isFalling = true

func _on_player_entered_body_entered(body: Node2D) -> void:
	if(body is Player && body.is_on_floor()):
		timer.start()
