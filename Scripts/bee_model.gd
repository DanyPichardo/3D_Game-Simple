extends Node3D

@onready var animation_tree: AnimationTree = %AnimationTree

func bite():
	animation_tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
