extends CharacterBody3D

const SPEED := 5.5
const JUMP_VELOCITY := 10.0

var cam = $CameraPivot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#func _unhandled_input(event):
	#if event is InputEventMouseMotion:
		#rotation_degrees.y -= event.relative.x * 0.2
		#$Camera3D.rotation_degrees.x -= event.relative.y * 0.2
		#$Camera3D.rotation_degrees.x = clamp(
			#$Camera3D.rotation_degrees.x, -80.0, 80.0
		#)
	#elif event.is_action_pressed("ui_cancel"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func _physics_process(delta:float):
	movimiento(delta)
	move_and_slide()

func movimiento(delta:float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0
	
	#Direction 
	var input_direction_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back"
	)
	var input_direction_3D = (transform.basis * Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)).normalized()
	if input_direction_3D:
		velocity.x = input_direction_3D.x * SPEED
		velocity.z = input_direction_3D.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.x, 0, SPEED)
