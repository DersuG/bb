# FlipComponent is a generic scene that helps with things that need to be
# flipped.
# 
# You can call face_right() or face_left(). You can also set scale.x in the
# inspector if you want something to start facing left. By default,
# FlipComponent faces right.
extends Node2D

var is_facing_right := true

# In case we are actually facing left:
func _ready() -> void:
	if sign(scale.x) < 0:
		is_facing_right = false

# Face right:
func face_right():
	if is_facing_right: return
	
	if sign(scale.x) < 0:
		scale.x *= -1
	
	is_facing_right = true

# Face left:
func face_left():
	if not is_facing_right: return
	
	if sign(scale.x) > 0:
		scale.x *= -1
	
	is_facing_right = false
