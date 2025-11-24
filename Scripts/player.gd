extends CharacterBody3D

const SPEED := 5.5
const JUMP_VELOCITY := 10.0
var mouse_sens := 0.1
var mouse_visible := false

@onready var cam = $CameraPivot

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta:float):
	movimiento(delta)
	move_and_slide()

#Camera movement
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
			cam.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-50), deg_to_rad(30))
	elif event.is_action_pressed("ui_cancel"):
		if mouse_visible == false:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			mouse_visible = true
		elif mouse_visible == true:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			mouse_visible = false

func movimiento(delta:float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#Jump
	velocity.y -= 10.0 * delta
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
