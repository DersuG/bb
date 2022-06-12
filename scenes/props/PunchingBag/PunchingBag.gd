extends KinematicBody2D

var state := "IDLE"

func _ready() -> void:
	$FlipComponent/IDLE_Sprite.visible = true
	$FlipComponent/DAMAGED_Sprite.visible = false
	$FlipComponent/FLYING_Sprite.visible = false
	$FlipComponent/DEAD_Sprite.visible = false
	$FlipComponent/IDLE_Hurtbox.active = true
	$FlipComponent/DAMAGED_Hurtbox.active = false

func hit(damage: float):
	print("Punching bag got hit for %f damage!" % damage)
	if state == "IDLE":
		state = "DAMAGED"
		$FlipComponent/IDLE_Sprite.visible = false
		$FlipComponent/DAMAGED_Sprite.visible = true
		$FlipComponent/FLYING_Sprite.visible = false
		$FlipComponent/DEAD_Sprite.visible = false
		$FlipComponent/IDLE_Hurtbox.active = false
		$FlipComponent/DAMAGED_Hurtbox.active = true
	elif state == "DAMAGED":
		state = "FLYING"
		$FlipComponent/IDLE_Sprite.visible = false
		$FlipComponent/DAMAGED_Sprite.visible = false
		$FlipComponent/FLYING_Sprite.visible = true
		$FlipComponent/DEAD_Sprite.visible = false
		$FlipComponent/IDLE_Hurtbox.active = false
		$FlipComponent/DAMAGED_Hurtbox.active = false
	elif state == "FLYING":
		state = "DEAD"
		$FlipComponent/IDLE_Sprite.visible = false
		$FlipComponent/DAMAGED_Sprite.visible = false
		$FlipComponent/FLYING_Sprite.visible = false
		$FlipComponent/DEAD_Sprite.visible = true
		$FlipComponent/IDLE_Hurtbox.active = false
		$FlipComponent/DAMAGED_Hurtbox.active = false

