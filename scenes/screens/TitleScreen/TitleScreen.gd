extends Node


func _ready() -> void:
	PATH.current_screen = self

func _on_Play_pressed() -> void:
	PATH.main.set_screen("res://scenes/screens/GameplayScreen/GameplayScreen.tscn")
