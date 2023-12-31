extends HSlider

@export var bus_name: String

var bus_index: int

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	value = State.master_vol

func _on_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	State.master_vol = value
