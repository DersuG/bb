extends Label

onready var player_controller := $"../.."



func _process(delta: float) -> void:
	text = ""
	for input in player_controller.input_buffer:
		text += "%s %s %s\n" % [input.frame, input.mode, input.action]
