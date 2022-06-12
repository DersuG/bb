extends Node2D

const FLOATING_TEXT_SCENE := preload("res://scenes/fx/FloatingText/FloatingText.tscn")

export var character_path := NodePath("../..")
onready var character: KinematicBody2D = get_node(character_path)

func validate(input_buffer: Array, delta: float) -> bool:
	
	if input_buffer.size() <= 0:
		return false
	
	if input_buffer[0].action == "null":
		return false
	
	if input_buffer[0].action == "punch" and input_buffer[0].mode == 1:
		if get_parent().fsm.get_current_node() == "DOUBLE_PUNCH":
			return true
	
	return false

func activate(input_buffer: Array, delta: float):
	print("TRIPLE_PUNCH")
	get_parent().add_input("null", 0)
	get_parent().fsm.travel("TRIPLE_PUNCH")
	
	var text = FLOATING_TEXT_SCENE.instance()
	text.text = "Triple Punch!!!"
	text.global_position = character.global_position
	character.get_parent().add_child(text)

func hit1():
	for hurtbox in $Hitbox.get_hit():
		hurtbox.hit(10)

func hit2():
	for hurtbox in $Hitbox2.get_hit():
		hurtbox.hit(10)

func hit3():
	for hurtbox in $Hitbox3.get_hit():
		hurtbox.hit(10)
