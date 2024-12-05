extends CanvasLayer

@onready var pause_panel: Panel = $PausePanel


func resume():
	get_tree().paused = false
	pause_panel.visible = false
	
func paused():
	get_tree().paused = true
	pause_panel.visible = true



func _on_resume_pressed() -> void:
	resume()
	


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_pause_button_pressed() -> void:
	if get_tree().paused:
		resume()  # If already paused, resume the game
	else:
		paused()
