extends Node

@export var context: PlayerContext
@export var playerGraphics: Node
@export var hearts: Array[Node]
@export var dmgReceive: DamageReceiveArea
@onready var sfx_player_damage: AudioStreamPlayer2D = $"../sfxPlayerDamage"


@export var times_blink_onhit: int = 3
@export var blink_timer: Timer
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
	blink_timer.start()
	while times_left > 0:
		playerGraphics.visible = false
		await blink_timer.timeout
		playerGraphics.visible = true
		await blink_timer.timeout
		times_left -= 1
	blink_timer.stop()
	dmgReceive.receive_damage = true
