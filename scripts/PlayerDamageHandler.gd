extends Node

@export var context: PlayerContext
@export var playerGraphics: Node
@export var hearts: Array[Node]
@export var dmgReceive: DamageReceiveArea
@onready var sfx_player_damage: AudioStreamPlayer2D = $"../sfxPlayerDamage"


@export var times_blink_onhit: int = 3
@export var delay_between_blinks: float = 0.1
var times_left: int

func _player_health_changed(oldHP: int, newHP: int) -> void:
	if(newHP < oldHP):
		for h in hearts.size():
			if (h < newHP):
				hearts[h].show()
				sfx_player_damage.play()
				if times_left == 0:
					times_left = times_blink_onhit
					_play_damage_animation()
				else:
					times_left = times_blink_onhit
			else:
				hearts[h].hide()
		pass

func _player_died() -> void:
	# TODO: If we want here is where we could but player death animation
	context.level.finish_lost()

func _play_damage_animation() -> void:
	dmgReceive.receive_damage = false
	while times_left > 0:
		playerGraphics.visible = false
		await get_tree().create_timer(delay_between_blinks).timeout
		playerGraphics.visible = true
		await get_tree().create_timer(delay_between_blinks).timeout
		times_left -= 1
	dmgReceive.receive_damage = true
