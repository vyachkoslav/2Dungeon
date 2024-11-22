extends Control

@export var menu: Control
@export var game: PackedScene

var game_node: Node

func _on_start_pressed() -> void:
	menu.visible = false
	game_node = game.instantiate()
	add_child(game_node)
	
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	pass # Replace with function body.
