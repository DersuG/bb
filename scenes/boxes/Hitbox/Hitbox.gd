extends Area2D

var frames_visible := 0

func get_hit() -> Array:
	show()
	var results := []
	for area in get_overlapping_areas():
		if area.is_in_group("Type.Hurtbox"):
			results.append(area)
	return results

func show():
	visible = true
	frames_visible = 5

func _ready() -> void:
	visible = false

func _physics_process(delta: float) -> void:
	if visible:
		frames_visible -= 1
	if frames_visible <= 0:
		visible = false
