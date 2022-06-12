extends KinematicBody2D


func hit(damage: float):
	print("Trashbag got hit for %f damage!" % damage)
	$AnimationStateMachineComponent.fsm.travel("DEAD")
