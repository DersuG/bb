# InputBuffer is where most of the character logic happens.
#
# 
#
#
extends Node2D

# Reference to the character. Set via inspector.
export var character_path := NodePath()
onready var character: KinematicBody2D = get_node(character_path)

# Reference to the animation state machine. Set via inspector.
export var animation_state_machine_component_path := NodePath()
onready var fsm: AnimationNodeStateMachinePlayback = get_node(animation_state_machine_component_path).get("parameters/playback")

# Input buffer, a list of InputBufferItems.
var input_buffer := []
const MAX_INPUT_BUFFER_SIZE := 20

# InputBufferItem represents an input.
class InputBufferItem:
	var action := ''		# The input action name.
	var mode := 0			# The input action mode. 1=down, 0=up.
	var frame := 0.0		# The frame number when the input happened.
	
	# Constructor.
	func _init(action: String, mode: int) -> void:
		self.action = action
		self.mode = mode
		self.frame = FPS.get_frame()
	
	# Gets the number of frames since the input event happened.
	func get_frames_since() -> float:
		return FPS.get_frame() - self.frame

# Adds an input to the input buffer.
func add_input(action: String, mode: int):
	var input := InputBufferItem.new(action, mode)
	input_buffer.push_front(input)
	if input_buffer.size() > MAX_INPUT_BUFFER_SIZE:
		input_buffer.pop_back()

# Reads this frame's inputs and adds them to the buffer. Called every frame by
# BaseCharacter.
func read_inputs(delta: float):
	
	if Input.is_action_just_pressed("p1_punch"):
		add_input("punch", 1) # Add the input "punch" with state 1 (down/pressed).
	if Input.is_action_just_released("p1_punch"):
		add_input("punch", 0) # Add the input "punch" with state 0 (up/released).
	
	if Input.is_action_just_pressed("p1_kick"):
		add_input("kick", 1)
	if Input.is_action_just_released("p1_kick"):
		add_input("kick", 0)
	
	if Input.is_action_just_pressed("p1_left"):
		add_input("left", 1)
	if Input.is_action_just_released("p1_left"):
		add_input("left", 0)
	
	if Input.is_action_just_pressed("p1_right"):
		add_input("right", 1)
	if Input.is_action_just_released("p1_right"):
		add_input("right", 0)
	
	if Input.is_action_just_pressed("p1_up"):
		add_input("up", 1)
	if Input.is_action_just_released("p1_up"):
		add_input("up", 0)
	
	if Input.is_action_just_pressed("p1_down"):
		add_input("down", 1)
	if Input.is_action_just_released("p1_down"):
		add_input("down", 0)
	
	# Check if any moves should be activated:
	for child in get_children():
		if not child.is_in_group("Type.Move"):
			continue
		
		# If the move is valid, activate it.
		if child.validate(input_buffer, delta):
			child.activate(input_buffer, delta)
			# NOTE: A move doesn't immediately begin when activated. Usually moves
			# use .travel() on the animation state machine, so it won't actually
			# run until the current animation ends. It's possible for .activate()
			# to be called multiple times, so .activate() should only be used for
			# calling .travel() on the state machine. Actual move logic should be
			# put in other functions and called from the animation itself.


