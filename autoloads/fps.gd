extends Node

var frame := 0

func _physics_process(delta: float) -> void:
	frame += 1

func get_frame() -> int:
	return frame
