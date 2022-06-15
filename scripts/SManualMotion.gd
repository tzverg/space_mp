extends RigidBody

enum MotionType{
	Impulse = 0,
	Force = 1
}

export var manual_motion : bool = false
export var motion_speed : int = 5

export(MotionType) var motion_type

var thr_physic_motion : Thread
var semaphore : Semaphore
var exit_thr_physic_motion : bool = false

var motion_direction : Vector3 = Vector3.ZERO

func _ready():
	thr_physic_motion = Thread.new()
	thr_physic_motion.start(self, "_thr_physic_motion_func")
	semaphore = Semaphore.new()

func _physics_process(delta):
	semaphore.post()
		
func _unhandled_key_input(event):
	if event.pressed:
		if manual_motion:
			if Input.is_action_pressed("move_up"):
				motion_direction = Vector3.UP
			elif Input.is_action_pressed("move_down"):
				motion_direction = Vector3.DOWN
				
			if Input.is_action_pressed("move_left"):
				motion_direction = Vector3.LEFT
			elif Input.is_action_pressed("move_right"):
				motion_direction = Vector3.RIGHT
				
			if Input.is_action_pressed("move_forward"):
				motion_direction = Vector3.FORWARD
			elif Input.is_action_pressed("move_backward"):
				motion_direction = Vector3.BACK

func _exit_tree():
	exit_thr_physic_motion = true
	semaphore.post()
	thr_physic_motion.wait_to_finish()
	
func _thr_physic_motion_func(userdata):
	while(true):
		semaphore.wait()
		
		if motion_direction:
			_physic_move()
		
		var should_exit = exit_thr_physic_motion
		if should_exit:
			break

func _physic_move():
	match(motion_type):
		MotionType.Impulse:
			apply_central_impulse(motion_direction * motion_speed)
		MotionType.Force:
			add_central_force(motion_direction * motion_speed)
		_:
			print("have no such motion type")
	
	motion_direction = Vector3.ZERO
