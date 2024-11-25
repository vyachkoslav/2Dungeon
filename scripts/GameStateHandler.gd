class_name GameStateHandler extends Control

@export var menu: Control
@export var levels: Array[PackedScene]

var _current_level: int = 0
var _level_node: Level

func _on_start_pressed() -> void:
	_current_level = 0
	menu.visible = false
	_level_node = levels[_current_level].instantiate() as Level
	_level_node.game = self
	add_child(_level_node)
	
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	pass # Replace with function body.
	
func stop_current_level() -> void:
	_current_level = 0
	_level_node.call_deferred("queue_free")
	menu.visible = true
	
func finish_current_level() -> void:
	_level_node.call_deferred("queue_free")
	_current_level += 1
	if _current_level >= levels.size():
		stop_current_level()
	else:
		_level_node = levels[_current_level].instantiate() as Level
		_level_node.game = self
		add_child(_level_node)
