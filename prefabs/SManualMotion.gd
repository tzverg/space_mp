extends RigidBody

export var manual_motion : bool = false

onready var parent : Spatial = get_node("../")

var impulse : Vector3 = Vector3.ZERO	

func _physics_process(delta):
	if manual_motion:
		if Input.is_action_pressed("ui_up"):
			impulse = Vector3.UP
		elif Input.is_action_pressed("ui_down"):
			impulse = Vector3.DOWN
			
		if Input.is_action_pressed("ui_left"):
			impulse = Vector3.LEFT
		elif Input.is_action_pressed("ui_right"):
			impulse = Vector3.RIGHT
			
		if impulse:
			print("v3: ", impulse)
			apply_central_impulse(impulse)
			impulse = Vector3.ZERO
