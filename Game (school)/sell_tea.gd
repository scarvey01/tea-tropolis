extends Button

func on_mouse_entered():
	$sell_tea_tooltip.visible = true  # Correct path if it's a child of 'gui'

func on_mouse_exit():
	$sell_tea_tooltip.visible = false

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exit)
