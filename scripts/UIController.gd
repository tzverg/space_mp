extends Control

func _physics_process(delta):
	if $fps_counter.visible:
		$fps_counter.text = "FPS : " + str(Engine.get_frames_per_second())
