extends Control

export var np_motion_object : NodePath
export var np_rtl_motion_type : NodePath
export var np_cb_motion_type : NodePath
export var np_fps_counter : NodePath
export var np_motion_x : NodePath
export var np_motion_y : NodePath
export var np_motion_z : NodePath

onready var rb_motion_object : RigidBody = null

onready var cb_motion_type : CheckButton = null

onready var rtl_fps_counter : RichTextLabel = null
onready var rtl_motion_type : RichTextLabel = null

onready var vs_motion_x : VSlider = null
onready var vs_motion_y : VSlider = null
onready var vs_motion_z : VSlider = null

var motion_direction : Vector3 = Vector3.ZERO

func _ready():
	_parse_links()
	_update_motion_type()

func _physics_process(delta):
	_update_fps_counter()
	_update_motion_vs()
	
func _parse_links():
	if np_fps_counter:
		rtl_fps_counter = get_node(np_fps_counter)
	
	if np_rtl_motion_type:
		rtl_motion_type = get_node(np_rtl_motion_type)
		
	if np_motion_object:
		rb_motion_object = get_node(np_motion_object)
		
	if np_cb_motion_type:
		cb_motion_type = get_node(np_cb_motion_type)
		
	if np_motion_x:
		vs_motion_x = get_node(np_motion_x)
	if np_motion_y:
		vs_motion_y = get_node(np_motion_y)
	if np_motion_z:
		vs_motion_z = get_node(np_motion_z)

func _update_fps_counter():
	if rtl_fps_counter.visible:
		rtl_fps_counter.text = "FPS : " + str(Engine.get_frames_per_second())

func _update_motion_type():
	var gds_manual_motion : GDScript = rb_motion_object.get_script()
#	print(gds_manual_motion.motion_type)

func _update_motion_vs():
	motion_direction = rb_motion_object.linear_velocity
	
	vs_motion_x.value = motion_direction.x
	vs_motion_y.value = motion_direction.y
	vs_motion_z.value = motion_direction.z
