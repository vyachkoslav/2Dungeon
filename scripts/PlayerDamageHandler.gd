extends Node

@export var context: PlayerContext
@export var hearts: Array[Node]
@onready var sfx_player_damage: AudioStreamPlayer2D = $"../sfxPlayerDamage"


func _player_health_changed(oldHP: int, newHP: int) -> void:
	if(newHP < oldHP):
		for h in hearts.size():
			if (h < newHP):
				hearts[h].show()
				sfx_player_damage.play()
			else:
				hearts[h].hide()
		pass

func _player_died() -> void:
	# TODO: Handle player death
	context.level.finish_lost()
