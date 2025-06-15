extends Node2D

var save_path_school = "user://savegame.tres"
func load_game1():
	if ResourceLoader.exists(save_path_school):
		var save_data = load(save_path_school) as SavedGame
		if save_data:
			print(save_data.tea)
			save_data.teaps 
			save_data.money
			save_data.money_all_time
			save_data.money_spent
			save_data.money_spent
			save_data.dark_mode
			save_data.level
			save_data.levelxp
			save_data.xp
			save_data.batch
			save_data.farmer_cost
			save_data.farmer_owned
			save_data.age_rack_owned
			save_data.aging_tea
			save_data.max_seed
			save_data.seed_cost
			save_data.seed_owned

			# Change to the game scene
			get_tree().change_scene_to_file("res://Game (school)/tea_tropolis_school.tscn")




func _on_load_save_school_pressed():
	load_game1()
	print("button clicked")
