extends Panel

@export var context: PlayerContext
@export var pause_panel: Node

func resume(): 
	get_tree().paused = false
	pause_panel.visible = false
	
func paused():
	get_tree().paused = true
	pause_panel.visible = true
	
func _on_resume_pressed() -> void:
	resume()
	
func _on_quit_pressed() -> void:
	context.level.quit_game()
	
func _on_pause_button_pressed() -> void:
	if get_tree().paused:
		resume()  # If already paused, resume the game
	else:
		paused()
		
func _on_main_menu_pressed() -> void:
	resume()
	context.level.return_to_menu()
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("menu")):
		_on_pause_button_pressed()
