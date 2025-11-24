extends RigidBody3D

@onready var bee_model: Node3D = $BeeModel

func attack():
	bee_model.bite()
	
