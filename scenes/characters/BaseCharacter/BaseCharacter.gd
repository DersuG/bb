# BaseCharacter is a generic character scene. Later we can "extend" it to make
# specific characters with their own sprites/movesets.
#
# Most of the logic is actually in the InputBuffer node.
extends KinematicBody2D

var velocity := Vector2.ZERO
var movement_vector := Vector2.ZERO

var is_movement_frozen := false


export var input_buffer_path := NodePath()
onready var input_buffer := get_node(input_buffer_path)


func apply_movement(movement: Vector2):
	movement_vector += movement
	movement_vector = movement_vector.normalized()

func _physics_process(delta: float) -> void:
	movement_vector = Vector2.ZERO
	input_buffer.read_inputs(delta)
	
	if is_movement_frozen:
		movement_vector = Vector2.ZERO
	
	if movement_vector.x < 0:
		$FlipComponent.face_left()
	elif movement_vector.x > 0:
		$FlipComponent.face_right()
	
	# Max speed:
	if velocity.length() > 500:
		velocity = velocity.normalized() * 500
	# Passive deceleration:
	if movement_vector == Vector2.ZERO:
		velocity *= max(0, 1.0 - 17.0 * delta)
	
	velocity += movement_vector * 8000 * delta
	
	move_and_collide(velocity * delta)

# Stops left/right/up/down movement. Doesn't stop other movement.
func freeze_movement():
	is_movement_frozen = true
func unfreeze_movement():
	is_movement_frozen = false

func hit(damage: float):
	print("Player got hit for %f damage!" % damage)
