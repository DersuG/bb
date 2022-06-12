extends Node2D

export var character_path := NodePath()
onready var character: KinematicBody2D = get_node(character_path)
export var animation_state_machine_component_path := NodePath()
onready var fsm: AnimationNodeStateMachinePlayback = get_node(animation_state_machine_component_path).get("parameters/playback")


var input_buffer := []
const MAX_INPUT_BUFFER_SIZE := 20

class InputBufferItem:
	var action := ''		# The input action name.
	var mode := 0			# The input action mode. 1=down, 0=up.
	var frame := 0.0		# The frame number when the input happened.
	
	# Constructor.
	func _init(action: String, mode: int) -> void:
		self.action = action
		self.mode = mode
#		self.timestamp = OS.get_ticks_msec()
		self.frame = FPS.get_frame()
	
	# Gets the amount of time since the input event happened.
#	func get_time_passed() -> float:
#		var elapsed_time := OS.get_ticks_msec() - self.timestamp
#		return elapsed_time
	# Gets the number of frames since the input event happened.
	func get_frames_since() -> float:
		return FPS.get_frame() - self.frame

func add_input(action: String, mode: int):
	var input := InputBufferItem.new(action, mode)
	input_buffer.push_front(input)
	if input_buffer.size() > MAX_INPUT_BUFFER_SIZE:
		input_buffer.pop_back()

func read_inputs(delta: float):
	
	if Input.is_action_just_pressed("p1_punch"):
		add_input("punch", 1)
	if Input.is_action_just_released("p1_punch"):
		add_input("punch", 0)
	
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
		if child.validate(input_buffer, delta):
			child.activate(input_buffer, delta)


