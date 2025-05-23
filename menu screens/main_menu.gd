extends Control



func _on_quit_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://menu screens/Mode Select.tscn")



func _on_load_game_pressed():
	get_tree().change_scene_to_file("res://load_game.tscn")
