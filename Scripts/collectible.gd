extends Area3D

@export var rotation_speed := 2.0
@export var bob_height := 0.3
@export var bob_speed := 3.0

var time := 0.0
var start_y := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	start_y = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	rotate_y(rotation_speed * delta)
	
	position.y = start_y + sin(time * bob_speed) * bob_height


func _on_body_entered(body):
	if body.is_in_group("player"):
		GameManager.add_coin()
		queue_free()
