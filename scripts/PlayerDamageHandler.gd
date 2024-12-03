extends Node

@export var context: PlayerContext
@export var hearts: Array[Node]

func _player_health_changed(oldHP: int, newHP: int) -> void:
	if(newHP < oldHP):
		for h in hearts.size():
			if (h < newHP):
				hearts[h].show()
			else:
				hearts[h].hide()
		pass

func _player_died() -> void:
	# TODO: If we want here is where we could but player death animation
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
