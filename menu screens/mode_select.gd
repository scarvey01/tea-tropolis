extends Control

func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu screens/Main Menu.tscn")

func _on_school_pressed():
	get_tree().change_scene_to_file("res://Game (school)/tea_tropolis_school.tscn")
