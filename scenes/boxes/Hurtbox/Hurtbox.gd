extends Area2D


export var entity_path := NodePath()
onready var entity: Node2D = get_node(entity_path)

var frames_visible := 0

func hit(damage: float):
	entity.hit(damage)

func show():
	visible = true
	frames_visible = 5

func _ready() -> void:
	visible = false

func _physics_process(delta: float) -> void:
	if visible:
		frames_visible -= 1
	if frames_visible <= 0:
		visible = false
	
	if monitorable:
		show()
