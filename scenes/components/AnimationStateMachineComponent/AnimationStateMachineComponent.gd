# AnimationStateMachine is a generic scene for making an animation state
# machine. You can access the state machine with the fsm variable, and call
# things like .travel() or .get_current_node() on it.
extends AnimationTree

onready var player: KinematicBody2D = get_parent()

onready var fsm: AnimationNodeStateMachinePlayback = get("parameters/playback")
