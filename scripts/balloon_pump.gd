extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("more balloons")
	if(body.has_method("blowUpBalloons")):
		body.blowUpBalloons()
