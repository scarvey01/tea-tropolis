extends Button

func on_mouse_entered():
	$farmer_tip.visible = true  # Correct path if it's a child of 'gui'

func on_mouse_exit():
	$farmer_tip.visible = false

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exit)
