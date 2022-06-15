extends Node2D

# Reference to the character. Set via inspector.
export var character_path := NodePath("../..")
onready var character: KinematicBody2D = get_node(character_path)

# Determine if this move is allowed to happen based on the current inputs.
func validate(input_buffer: Array, delta: float) -> bool:
	
	# If input buffer is empty, don't activate.
	if input_buffer.size() <= 0:
		return false
	
	# If first input is a null input, don't activate.
	if input_buffer[0].action == "null":
		return false
	
	# If first input is kick-pressed, activate.
	if input_buffer[0].action == "kick" and input_buffer[0].mode == 1:
		if get_parent().fsm.get_current_node() == "IDLE":
			return true
	
	return false

# Try to start this move.
# NOTE: A move doesn't immediately begin when activated. Usually moves
# use .travel() on the animation state machine, so it won't actually
# run until the current animation ends. It's possible for .activate()
# to be called multiple times, so .activate() should only be used for
# calling .travel() on the state machine. Actual move logic should be
# put in other functions and called from the animation itself.
func activate(input_buffer: Array, delta: float):
	print("KICK")
	
	# Add a input called "null" to the input buffer. This stops moves from
	# repeating over and over. For example, if you hit punch, "punch" would be 
	# added to the buffer. The PUNCH move would check if the latest input was
	# "punch", and activate if so. Without a null input, PUNCH would keep
	# activating over and over until another input is added.
	get_parent().add_input("null", 0)
	get_parent().fsm.travel("KICK")
