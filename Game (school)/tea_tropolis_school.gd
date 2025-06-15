extends Node2D
var setting_menu_open = true
var dark_mode = false
var level = 1 #LEVEL LEVEL LEVEL LEVEL LEVEL LEVEL
var xp = 0 #########################
var levelxp = 50########################
var tea = 0## TEA TEA TEA TEA TEA TEA TEA TEA
var teaps = 1
var tea_all_time = 0 
var teatomoney = 0.5
var money = 0 ### Money Money Money Money Money Money
var money_all_time = 0
var money_spent = 0
var seed_cost = 0
var max_seed = 9
var seed_owned = 0
var farmer_cost = 100
var farmer_owned = 0
var age_rack_owned = false
var age_rack_cost = 2500
var aging_cost = 1000
var aging_tea = 0
var Timer2 = Timer.new()
var batch = false
#######################################################################################################


func save_game():
	var saved_game:SavedGame = SavedGame.new()
	
	saved_game.dark_mode = dark_mode
	saved_game.tea = tea
	saved_game.teaps = teaps
	saved_game.teatomoney = teatomoney
	saved_game.tea_all_time = tea_all_time
	saved_game.money = money
	saved_game.money_all_time = money_all_time
	saved_game.money_spent = money_spent
	saved_game.level = level
	saved_game.levelxp = levelxp
	saved_game.xp = xp
	saved_game.seed_cost = seed_cost
	saved_game.max_seed = max_seed
	saved_game.max_seed = seed_owned
	saved_game.farmer_cost = farmer_cost
	saved_game.farmer_owned = farmer_owned
	saved_game.age_rack_owned = age_rack_owned
	saved_game.aging_tea = aging_tea
	saved_game.batch = batch
	
	ResourceSaver.save(saved_game, "user://savegame.tres")
	
func load_game():
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	var _darkmode = saved_game.dark_mode

func _ready():
	# Create a new Timer
	Timer2.stop()
	var timer1 = Timer.new()
	timer1.wait_time = 1.0
	timer1.one_shot = false

	# Add the timer to the scene tree
	add_child(timer1)

	# Connect the signal
	timer1.timeout.connect(_on_timer1_timeout)
	timer1.start()
	
func _on_timer1_timeout(): #REFRESHES EVERYTHING
	tea += teaps
	tea_all_time += teaps
	update_all()
func check_level():
	age_rack_level()
#RIGHT SIDE OF SCREEN VALUES RIGHT SIDE OF SCREEN VALUES RIGHT SIDE OF SCREEN VALUES
func _process(_delta):
	display_slider_tea()
	display_needed_xp()
	diplay_xp_bar()
	check_level()
	display_tea()
	display_money()
	check_level()
	display_teaps()
	display_total_tea()
	display_total_money()
	display_money_spent()
	display_seed_cost()
	display_farmer_cost()
	display_seed_owned()
	display_farmer_owned()
	display_buy_aging_rack()
	display_age_cost()
	display_slider_tea()
	display_age_time()
func display_tea():
	$gui/Teaamt.text = "Tea: " + str(int(tea))
func display_money():
	$gui/Money.text = "Money: " + str(money)
func display_teaps():
	$gui/tea_ps.text = "Tea p/s: " + str(teaps)
func _on_sell_tea_pressed():
	money+= tea * teatomoney
	money_all_time+= tea * teatomoney
	tea = 0	
func display_level():
	$gui/Level.text = "Level: " + str(level)
func display_needed_xp():
	$gui/level_xp_need.text = str(xp) + "/" + str(levelxp)
func diplay_xp_bar():
	$gui/ProgressBar.max_value = levelxp	
	$gui/ProgressBar.min_value = 0
	$gui/ProgressBar.value = xp
func leveling():
	if xp >= levelxp:
		level += 1
		levelxp += 25
		xp = 0
func display_age_tea_cost():
	$gui/Buffs/age_tea.text = "Age Tea: $" + str (aging_cost)
func _on_age_tea_pressed():
	if money >= aging_cost and not batch:
		money -= aging_cost
		money_spent += aging_cost
		xp += 10
		tea -= $gui/Buffs/age_slider.value
		aging_tea += $gui/Buffs/age_slider.value
		batch = true
		aging_tea_timer()
func aging_tea_timer():
	Timer2.wait_time = 300.0
	Timer2.one_shot = true
	add_child(Timer2)
	Timer2.timeout.connect(timer2_timeout)
	Timer2.start()
func timer2_timeout():
	teatomoney += 0.5
	money += aging_tea * teatomoney
	aging_tea = 0
	teatomoney -= 0.5	
func display_age_time():
	$"gui/Buffs/Time reamaing".text = "Time Remaing: " + str(int(Timer2.time_left)) + "s"
func tea_slider():
	$gui/Buffs/age_slider.min_value = 1
	$gui/Buffs/age_slider.max_value = tea
func display_slider_tea():
	$gui/Buffs/age_tea_text.text = "age tea: " + str(int($gui/Buffs/age_slider.value))
#BUY FARMING BUY FARMING BUY FARMING BUY FARMING BUY FARMING
func _on_buy_seeds_pressed():
	if money >= seed_cost and seed_owned <= max_seed:
		money -= seed_cost
		money_spent += seed_cost
		seed_cost += 5
		seed_owned += 1
		xp += 10
		teaps += 1
func display_seed_cost():
	$gui/Farming/buy_seeds.text = "Buy Seeds: $" + str(seed_cost)
func display_farmer_cost():
	$gui/Farming/Buy_farmer.text = "Hire Farmers: $" + str(farmer_cost)
func _on_buy_farmer_pressed():
	if level >= 2 and money >= farmer_cost:
		money -= farmer_cost
		farmer_owned += 1
		money_spent += farmer_cost
		farmer_cost += 50
		max_seed += 2
		xp += 20
func display_seed_owned():
	$gui/Farming/seed_owned.text = "Owned: " + str(seed_owned)
func display_farmer_owned():
	$gui/Farming/farmer_owned.text = "Hired: " +str(farmer_owned)
func age_rack_level():
	if level >= 3:
		$gui/Farming/buy_aging_rack.visible =true
func display_buy_aging_rack():
	if not age_rack_owned:
		$gui/Farming/buy_aging_rack.text = "Buy Aging Rack: $" + str(age_rack_cost)
	else:
		$gui/Farming/buy_aging_rack.visible = false
func _on_buy_aging_rack_pressed():
	if money >= age_rack_cost and level >= 5:
		money -= age_rack_cost
		money_spent += age_rack_cost
		xp+= 25
		$gui/Farming/buy_aging_rack.visible = false
		$gui/Buffs/age_tea.visible = true
		$gui/Buffs.visible = true
		age_rack_owned = true
func display_age_cost():
	$gui/Buffs/age_tea.text = "age tea: $" + str(aging_cost)
#SETTINGS MENU SETTINGS MENU SETTINGS MENUSETTINGS MENU SETTINGS MENU SETTINGS MENU 
func openclosesettings(): #Toggles visibility of settings menu node
	if setting_menu_open:
		$"gui/settings menu".visible = true
		$"gui/settings menu/settings menu/settings options".visible = true
		setting_menu_open = false
	elif not setting_menu_open:
		$"gui/settings menu".visible = false
		$"gui/settings menu/settings menu/settings options".visible = false
		setting_menu_open = true
		display_tea()
func _on_settings_button_pressed(): 
	openclosesettings()
func _input(event): 
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			openclosesettings()
func _on_quit_pressed():
	get_tree().quit()
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://menu screens/Main Menu.tscn")
func display_total_tea():
	$"gui/settings menu/settings menu/settings options/total_tea".text = "Total Tea Collected: " + str(tea_all_time)
func display_total_money():
	$"gui/settings menu/settings menu/settings options/total_money".text = "Total Earnings: " + str(money_all_time)
func display_money_spent():
	$"gui/settings menu/settings menu/settings options/money_spent".text = "Money Spent: " + str(money_spent)
func dark_mode1(): #toggles visibility of gray box
	if dark_mode:
		$Base/gray.visible = false
		dark_mode = false
	elif not dark_mode:
		$Base/gray.visible = true
		dark_mode = true
func _on_darkmode_pressed():
	dark_mode1()

func update_all():
	save_game()
	display_tea()
	display_money()
	check_level()
	display_teaps()
	display_total_tea()
	display_total_money()
	display_money_spent()
	display_seed_cost()
	display_farmer_cost()
	display_seed_owned()
	display_farmer_owned()
	display_level()
	display_needed_xp()
	diplay_xp_bar()
	leveling()
	display_buy_aging_rack()
	display_age_cost()
	display_slider_tea()
	tea_slider()
	display_age_time()
