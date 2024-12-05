extends HSlider

@export var audioPlayer: AudioStreamPlayer
@export var clip: AudioStream

func _ready() -> void:
	# Set the slider range to match the audio bus volume range (-60 dB to 0 dB)
	min_value = 0  # Minimum volume (mute)
	max_value = 1  # Maximum volume
	step = 0.01    # Step size for volume adjustments
	exp_edit = false

	value_changed.connect(_on_value_changed)
	drag_started.connect(_on_drag_started)
	drag_ended.connect(_on_drag_ended)

	value = 1+AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))/60

func _on_drag_started() -> void:
	audioPlayer.stream = clip
	audioPlayer.play(0)

func _on_drag_ended(_ended: bool) -> void:
	audioPlayer.stop()
	audioPlayer.stream = null

func _on_value_changed(new_value: float) -> void:
	new_value=60*(1-(1-new_value)**2) # slow at beggining fast at end
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -60+new_value)
