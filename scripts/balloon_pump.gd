extends Node2D

@onready var player: CharacterBody2D = $"../Player"
@onready var interaction: Sprite2D = $interaction
var isInteractable = false

func _process(delta: float) -> void:
	if(isInteractable &&  Input.is_action_just_pressed("pump")):
		player.blowUpBalloons()

func _on_area_2d_body_entered(body: Node2D) -> void:
	interaction.visible = true
	isInteractable = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	interaction.visible = false
	isInteractable = false
