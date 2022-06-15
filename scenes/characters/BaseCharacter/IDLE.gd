extends Node2D

export var character_path := NodePath("../..")
onready var character: KinematicBody2D = get_node(character_path)

func validate(input_buffer: Array, delta: float) -> bool:
	
	# If we are in IDLE, activate.
	if get_parent().fsm.get_current_node() == "IDLE":
		return true
	return false

func activate(input_buffer: Array, delta: float):
	# Do nothing lmao.
	pass

func _physics_process(delta: float) -> void:
	if get_parent().fsm.get_current_node() != "IDLE":
		$Hurtbox.active = false
