extends Area2D

@onready var health = $"../Player_CharacterBody2D/PlayerHealth"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player_CharacterBody2D":
		health.decrease_health()
