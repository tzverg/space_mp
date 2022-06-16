extends Panel

export var np_motion_object : NodePath

onready var rb_motion_object : RigidBody = null

signal change_motion_direction(current_motion_direction)

var motion_direction : Vector3 = Vector3.ZERO

func _ready():
	_parse_links()
	
func _physics_process(delta):
	_update_motion_vs()
	
func _parse_links():
	if np_motion_object:
		rb_motion_object = get_node(np_motion_object)
		
func _update_motion_vs():
	if visible:
		motion_direction = rb_motion_object.linear_velocity		
		emit_signal("change_motion_direction", motion_direction)
