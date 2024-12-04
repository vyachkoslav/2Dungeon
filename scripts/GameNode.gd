class_name GameNode extends Node2D

var game: GameStateHandler
@export var music: AudioStream

func return_to_menu() -> void:
	game.return_to_menu()
	
func quit_game() -> void:
	game.quit()
