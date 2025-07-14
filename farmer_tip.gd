extends PanelContainer

const offest: Vector2 = Vector2.ONE *17
func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() +offest
