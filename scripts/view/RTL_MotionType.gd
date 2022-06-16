extends RichTextLabel

func _on_camera_entity_change_motion_type(current_motion_type):
	if visible:
		text = current_motion_type
