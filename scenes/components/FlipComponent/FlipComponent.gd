extends Node2D

var is_facing_right := true

# In case we are actually facing left:
func _ready() -> void:
	if sign(scale.x) < 0:
		is_facing_right = false

func face_right():
	if is_facing_right: return
	
	if sign(scale.x) < 0:
		scale.x *= -1
	
	is_facing_right = true

func face_left():
	if not is_facing_right: return
	
	if sign(scale.x) > 0:
		scale.x *= -1
	
	is_facing_right = false
