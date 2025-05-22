extends Node2D
var setting_menu_open = true
var dark_mode = false
var level = 1
var xp = 90
var levelxp = 100
var tea = 20
var teaps = 1
var tea_all_time = 0
var teatomoney = 0.5
var money = 0
var money_all_time = 0
var money_spent = 0
var seed_cost = 10
var max_seed = 10
var seed_owned = 0
var farmer_cost = 100
var farmer_owned = 0

func _ready():
	# Create a new Timer
	var timer1 = Timer.new()
	timer1.wait_time = 1.0
	timer1.one_shot = false

	# Add the timer to the scene tree
	add_child(timer1)

	# Connect the signal
	timer1.timeout.connect(_on_timer1_timeout)
	timer1.start()
	tea += teaps
	tea_all_time += teaps
func _on_timer1_timeout(): #REFRESHES EVERYTHING
	tea += teaps
	tea_all_time += teaps
	update_all()
#RIGHT SIDE OF SCREEN VALUES RIGHT SIDE OF SCREEN VALUES RIGHT SIDE OF SCREEN VALUES
func display_tea():
	$gui/Teaamt.text = "Tea: " + str(tea)
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
		levelxp += 50
		xp = 0
#BUY STUFF LEFT SIDE BUY STUFF LEFT SIDE BUY STUFF LEFT SIDE  BUY STUFF LEFT SIDE  BUY STUFF LEFT SIDE
func _on_buy_seeds_pressed():
	if money >= seed_cost and seed_owned <= max_seed:
		money -= seed_cost
		money_spent += seed_cost
		seed_cost += 10
		seed_owned += 1
		xp += 10
		teaps += 1
func display_seed_cost():
	$gui/Farming/buy_seeds.text = "Buy Seeds: $" + str(seed_cost)
func _on_buy_farmers_pressed():
	money -= farmer_cost
	farmer_cost += 100
	max_seed += 2
func display_farmer_cost():
	$"gui/Farming/Buy_farmers".text = "Hire Farmers: $" + str(farmer_cost)
func display_seed_owned():
	$gui/Farming/seed_owned.text = "Owned: " + str(seed_owned)
func display_farmer_owned():
	$gui/Farming/farmer_owned.text = "Hired: " +str(farmer_owned)
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
	display_tea()
	display_money()
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
