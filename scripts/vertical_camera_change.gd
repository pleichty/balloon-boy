extends Area2D

@onready var push_camera: Camera2D = $"../PushCamera"

func _on_body_entered(body: Node2D) -> void:
	if(body is Player):
		push_camera.swapDirection('vertical')
