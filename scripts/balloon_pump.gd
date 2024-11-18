extends Node2D

@onready var player: Player = %Player
@onready var interaction: Sprite2D = $interaction
var isInteractable = false

func _process(_delta: float) -> void:
	if(isInteractable &&  Input.is_action_just_pressed("pump")):
		player.blowUpBalloons()
		visible = false
	elif(!isInteractable):
		visible = true

func _on_area_2d_body_entered(_body: Node2D) -> void:
	interaction.visible = true
	isInteractable = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	interaction.visible = false
	isInteractable = false
