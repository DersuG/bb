extends Node


func set_screen(screen_path: String):
	var screen_scene: PackedScene = load(screen_path)
	for child in get_children():
		if child.is_in_group("Type.Screen"):
			child.queue_free()
	var screen = screen_scene.instance()
	add_child(screen)
