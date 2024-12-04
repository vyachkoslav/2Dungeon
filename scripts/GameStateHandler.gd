class_name GameStateHandler extends Control

@export var menu: Control
@export var levels: Array[PackedScene]
@export var won_screen: PackedScene
@export var lost_screen: PackedScene
@export var music_player: AudioStreamPlayer

var _current_level: int = 0
var _current_node: GameNode

func _start_node(scene: PackedScene) -> void:
	_current_node = scene.instantiate() as GameNode
	_current_node.game = self
	add_child(_current_node)
	if(music_player.stream != _current_node.music):
		if(_current_node.music != null):
			music_player.stream = _current_node.music
			music_player.play()
		else:
			music_player.stop()
			music_player.stream = null
			
func _start_level(index: int) -> void:
	_start_node(levels[index])
	
func _on_start_pressed() -> void:
	$OptionsContainer.visible = false
	_current_level = 0
	menu.visible = false
	_start_level(_current_level)
	
func quit() -> void:
	get_tree().quit()
func _on_quit_pressed() -> void:
	quit()



func _on_options_pressed() -> void:
	$OptionsContainer.visible = !$OptionsContainer.visible
	$CreditsContainer.visible = false
	

func _on_credits_pressed() -> void:
	$CreditsContainer.visible = !$CreditsContainer.visible
	$OptionsContainer.visible = false
	
func _stop_current_node() -> void:
	if(_current_node == null): return
	
	_current_level = 0
	_current_node.call_deferred("queue_free")
	music_player.stop()
	music_player.stream = null
	
func return_to_menu() -> void:
	_stop_current_node()
	menu.visible = true

func _show_screen(screen: PackedScene) -> void:
	_stop_current_node()
	menu.visible = false
	_start_node(screen)

func show_lost_screen() -> void:
	_show_screen(lost_screen)
	
func show_won_screen() -> void:
	_show_screen(won_screen)

func finish_current_level() -> void:
	_current_node.call_deferred("queue_free")
	_current_level += 1
	if _current_level >= levels.size():
		show_won_screen()
	else:
		_start_level(_current_level)
