extends Node2D

@onready var area_2d: Area2D = $AnimatedSprite2D/Area2D
@onready var visible_on_screen_enabler_2d: VisibleOnScreenEnabler2D = $VisibleOnScreenEnabler2D

var speed = 150;

# Called when the node enters the scene tree for the first time.
func start(pos):
	position = pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Player):
		body.enemyHit()
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
