extends CharacterBody3D

@onready var mesh = $Collision/Mesh

var target_array:Array
var current_target

var base_speed:float = 50
var base_acceleration:float = 5

func _ready():
	# Find player entity.
	find_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = position.direction_to(current_target.position) * base_speed * delta
	
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
