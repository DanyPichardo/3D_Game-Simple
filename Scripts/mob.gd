extends RigidBody3D

@onready var bee_model: Node3D = $BeeModel
@onready var player = get_node("/root/Main/Player")

var speed = randf_range(2.0, 4.0)

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0.0
	linear_velocity = direction * speed
	

func attack():
	bee_model.bite()
