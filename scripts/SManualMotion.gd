extends RigidBody

enum MotionType{
	Impulse = 0,
	Force = 1
}

export var manual_motion : bool = false
export(MotionType) var motion_type

var direction : Vector3 = Vector3.ZERO

var thr_physic_motion : Thread
var semaphore : Semaphore
var exit_thr_physic_motion : bool = false

func _ready():
	thr_physic_motion = Thread.new()
	thr_physic_motion.start(self, "_thr_physic_motion_func")
	semaphore = Semaphore.new()

func _physics_process(delta):
	semaphore.post()
		
func _unhandled_key_input(event):
	if event.pressed:
		if manual_motion:
			if Input.is_action_pressed("ui_up"):
				direction = Vector3.UP
			elif Input.is_action_pressed("ui_down"):
				direction = Vector3.DOWN
				
			if Input.is_action_pressed("ui_left"):
				direction = Vector3.LEFT
			elif Input.is_action_pressed("ui_right"):
				direction = Vector3.RIGHT

func _exit_tree():
	exit_thr_physic_motion = true
	semaphore.post()
	thr_physic_motion.wait_to_finish()
	
func _thr_physic_motion_func(userdata):
	while(true):
		semaphore.wait()
		
		if direction:
			_physic_move()
		
		var should_exit = exit_thr_physic_motion
		if should_exit:
			break

func _physic_move():
	if motion_type == MotionType.Impulse:
		apply_central_impulse(direction)
	elif motion_type == MotionType.Force:
		add_central_force(direction)
		
	direction = Vector3.ZERO
