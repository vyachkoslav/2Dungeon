class_name Level extends Node2D

var game: GameStateHandler

func _on_level_finish_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		call_deferred("finish_won")

func finish_won() -> void:
	game.finish_current_level()
	
func finish_lost() -> void:
	game.stop_current_level()
