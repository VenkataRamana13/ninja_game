extends Area2D

func _on_body_entered(body):
	if "Player" in body.name:
		get_tree().change_scene_to_file("res://world.tscn")


func _on_body_exited(body):
	pass # Replace with function body.
