extends Node2D
var projectile_scene = preload("res://scenes/enemy_projectile.tscn")
@onready var visible_on_screen_enabler_2d: VisibleOnScreenEnabler2D = $VisibleOnScreenEnabler2D
@onready var shoot_timer: Timer = $ShootTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	shoot_timer.start(2)


func _on_shoot_timer_timeout() -> void:
	var projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	projectile.start(position)
	shoot_timer.start(2)
