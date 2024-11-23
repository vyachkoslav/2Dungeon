extends Area2D

@onready var player = $"../Player_CharacterBody2D"

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player_CharacterBody2D":
		player.decrease_health()
		
