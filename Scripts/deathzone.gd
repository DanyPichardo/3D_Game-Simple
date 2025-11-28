extends Area3D

func _ready():
	pass
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		reset_game()
		
func reset_game():
	GameManager.reset_coins()
	get_tree().call_deferred("reload_current_scene")
