extends Label

@export var appearTimer: Timer
@onready var textToShow = self.text
var nextLetter: int = 0

func _ready() -> void:
	text = ""
	appearTimer.timeout.connect(_on_timer_tick)
	
func text_hide() -> void:
	appearTimer.stop()
	text = ""
	nextLetter = 0

func text_appear() -> void:
	if(!appearTimer.is_stopped() || nextLetter == textToShow.length()): return
	appearTimer.start()

func text_appear_instant() -> void:
	appearTimer.stop()
	text = textToShow
	nextLetter = textToShow.length()
	
func _on_timer_tick() -> void:
	if(nextLetter == textToShow.length()):
		appearTimer.stop()
		return
	text += textToShow[nextLetter]
	nextLetter += 1

func _on_hint_area_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		text_appear()
		
func _on_next_hint_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		text_appear_instant()
