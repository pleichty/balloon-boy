extends Area2D
@onready var level_finish: Area2D = $"."

const FILE_PREFIX = "res://levels/level_"

func _on_body_entered(body: Node2D) -> void:
	if(body is Player):
		var current_level = get_tree().current_scene.scene_file_path
		var next_level_number = current_level.to_int() + 1
		
		var next_level_path = FILE_PREFIX + str(next_level_number) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
