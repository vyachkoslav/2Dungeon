extends Node

@export var context: PlayerContext

func _ready() -> void:
	context.keyManager.connect("NewKey", _on_new_key)
	
func _on_new_key(_id: int) -> void:
	self.visible = true
