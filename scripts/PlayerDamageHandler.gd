extends Node

@export var context: PlayerContext

func _player_health_changed(oldHP: int, newHP: int) -> void:
	if(newHP < oldHP):
		# TODO: Handle receiving damage
		pass

func _player_died() -> void:
	# TODO: Handle player death
	context.level.finish_lost()
