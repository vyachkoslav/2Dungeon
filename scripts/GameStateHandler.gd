class_name GameStateHandler extends Control

@export var menu: Control
@export var levels: Array[PackedScene]
@export var music_player: AudioStreamPlayer

var _current_level: int = 0
var _level_node: Level

func _start_level(index: int) -> void:
	_level_node = levels[index].instantiate() as Level
	_level_node.game = self
	add_child(_level_node)
	if(music_player.stream != _level_node.music):
		if(_level_node.music != null):
			music_player.stream = _level_node.music
			music_player.play()
		else:
			music_player.stop()
			music_player.stream = null
			
func _on_start_pressed() -> void:
	_current_level = 0
	menu.visible = false
	_start_level(_current_level)
	
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	pass # Replace with function body.
	
func stop_current_level() -> void:
	_current_level = 0
	_level_node.call_deferred("queue_free")
	music_player.stop()
	music_player.stream = null
	menu.visible = true
	
func finish_current_level() -> void:
	_level_node.call_deferred("queue_free")
	_current_level += 1
	if _current_level >= levels.size():
		stop_current_level()
	else:
		_start_level(_current_level)
