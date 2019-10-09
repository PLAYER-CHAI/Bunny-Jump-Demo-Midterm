extends Node2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player_A":
			get_tree().change_scence("res://Scenes/Levels/Level1.tscn")
