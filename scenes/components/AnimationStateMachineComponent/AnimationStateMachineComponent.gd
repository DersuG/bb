extends AnimationTree

onready var player: KinematicBody2D = get_parent()

onready var fsm: AnimationNodeStateMachinePlayback = get("parameters/playback")
