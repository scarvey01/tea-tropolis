extends Node2D
var setting_menu_open = true
var tea = 0
var teaps = 1
var tea_all_time = 0
var teatomoney = 0.5
var money = 0
var money_all_time = 0


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
	display_tea()
	display_money()
	display_teaps()
	display_total_tea()
	display_total_money()
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
