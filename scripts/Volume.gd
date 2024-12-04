extends HSlider


func _ready() -> void:
	# Set the slider range to match the audio bus volume range (-60 dB to 0 dB)
	min_value = -60  # Minimum volume (mute)
	max_value = 0    # Maximum volume
	step = 1         # Step size for volume adjustments

	value_changed.connect(_on_value_changed)

	value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))


func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), new_value)
