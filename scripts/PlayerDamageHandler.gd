extends Node

func _player_health_changed(oldHP: int, newHP: int) -> void:
	if(newHP < oldHP):
		# TODO: Handle receiving damage
		pass

func _player_died() -> void:
	# TODO: Handle player death
	GameStateHandler.instance.stop_current_level()
