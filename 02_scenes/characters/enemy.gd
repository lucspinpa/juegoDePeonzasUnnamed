extends CharacterBody3D

@onready var mesh = $Collision/Mesh

var target_array:Array
var current_target

var speed:float = 50
var acceleration:float = 5

func _ready():
	# Find player entity.
	find_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector3(position.direction_to(current_target.position).normalized().x,
		0,
		position.direction_to(current_target.position).normalized().z) * speed * delta
	
	var rotation_multiplier = clamp(
		((abs(velocity.x) + abs(velocity.z)) / 100),
		0.0, 1.0)
	mesh.rotation.y += 9 * rotation_multiplier
	
	move_and_slide()

func find_target():
	target_array.append(get_tree().get_first_node_in_group("player"))
	for i in get_tree().get_nodes_in_group("enemies"):
		target_array.append(i)
	
	var random_number = randi_range(0,4)
	
	# There's a 60% chance for an enemy to pick the player as its target.
	if random_number > 1:
		current_target = target_array[0]
	else:
		for i in target_array:
			if i !=target_array[0] and i != self and i != null:
				current_target = i
				break
			else:
				continue
	
	print(str(self) + " target is " + str(current_target))
