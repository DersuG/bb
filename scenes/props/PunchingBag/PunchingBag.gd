extends KinematicBody2D

var state := "IDLE"

func _ready() -> void:
	$FlipComponent/IDLE_Sprite.visible = true
	$FlipComponent/DAMAGED_Sprite.visible = false
	$FlipComponent/FLYING_Sprite.visible = false
	$FlipComponent/DEAD_Sprite.visible = false
	$FlipComponent/IDLE_Hurtbox.monitorable = true
	$FlipComponent/DAMAGED_Hurtbox.monitorable = false

func hit(damage: float):
	print("Punching bag got hit for %f damage!" % damage)
	if state == "IDLE":
		state = "DAMAGED"
		$FlipComponent/IDLE_Sprite.visible = false
		$FlipComponent/DAMAGED_Sprite.visible = true
		$FlipComponent/FLYING_Sprite.visible = false
		$FlipComponent/DEAD_Sprite.visible = false
		$FlipComponent/IDLE_Hurtbox.monitorable = false
		$FlipComponent/DAMAGED_Hurtbox.monitorable = true
	elif state == "DAMAGED":
		state = "FLYING"
		$FlipComponent/IDLE_Sprite.visible = false
		$FlipComponent/DAMAGED_Sprite.visible = false
		$FlipComponent/FLYING_Sprite.visible = true
		$FlipComponent/DEAD_Sprite.visible = false
		$FlipComponent/IDLE_Hurtbox.monitorable = false
		$FlipComponent/DAMAGED_Hurtbox.monitorable = false
	elif state == "FLYING":
		state = "DEAD"
		$FlipComponent/IDLE_Sprite.visible = false
		$FlipComponent/DAMAGED_Sprite.visible = false
		$FlipComponent/FLYING_Sprite.visible = false
		$FlipComponent/DEAD_Sprite.visible = true
		$FlipComponent/IDLE_Hurtbox.monitorable = false
		$FlipComponent/DAMAGED_Hurtbox.monitorable = false

