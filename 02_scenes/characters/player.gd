extends CharacterBody3D

@onready var mesh = $Collision/Mesh

const JUMP_VELOCITY = 4.5

var max_speed = 2.0
@export var acceleration = 5.0
var count = 0
@export var max_count = 15

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	
	var is_pressed : bool = Input.is_action_pressed("down") || Input.is_action_pressed("up") || Input.is_action_pressed("right") || Input.is_action_pressed("left")
	
	if is_pressed:
		count = clamp(count+0.05,0,max_count)
	else:
		count = 0
	
	print(count)
	
	if input_dir:
		# If there is an input, calculate velocity.
		# Adds acceleration to the current velocity each frame. Clamps it not to exceed max speed.
		velocity.x = clamp(velocity.x + acceleration * delta * input_dir.x * count, -max_speed, max_speed)
		velocity.z = clamp(velocity.z + acceleration * delta * input_dir.y * count, -max_speed, max_speed)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * delta)
		velocity.z = move_toward(velocity.z, 0, acceleration * delta)

	var rotation_multiplier = clamp(
			((abs(velocity.x) + abs(velocity.z)) / 100),
			0.0, 1.0)
	mesh.rotation.y += 9 * rotation_multiplier

	move_and_slide()
