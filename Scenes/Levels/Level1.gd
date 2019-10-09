extends Node2D

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if $Player_A.is_dead():
		get_tree().reload_current_scene()