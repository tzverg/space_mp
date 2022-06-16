extends VSlider

func _on_P_Engine_change_motion_direction(current_motion_direction):
	if visible:
		value = current_motion_direction.y
