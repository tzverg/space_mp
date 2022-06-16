extends RichTextLabel

func _physics_process(delta):
	if visible:
		text = "FPS : " + str(Engine.get_frames_per_second())
