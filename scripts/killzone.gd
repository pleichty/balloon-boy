extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print('body', body)
	if(body is Player):
		body.enemyHit()
	elif(body is Balloons):
		body.onHit()
