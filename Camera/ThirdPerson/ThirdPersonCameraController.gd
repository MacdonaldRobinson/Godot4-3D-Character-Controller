extends Node3D
class_name CameraController

enum Mode {
	First_Person,
	Third_Person
}

@export var camera_mode: Mode
@export var look_at_node: Node3D

@onready var camera: Camera3D = $SpringArm3D/Camera3D
@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var camera_look_at_point: Node3D = $SpringArm3D/Camera3D/CameraLookAtPoint

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	set_camera_mode(camera_mode)
	
func set_camera_mode(new_camera_mode: Mode):
	camera_mode = new_camera_mode
	
	if camera_mode == Mode.First_Person:
		spring_arm.spring_length = 0
	elif camera_mode == Mode.Third_Person:
		spring_arm.spring_length = 5	
		
func get_camera_look_at_point():
	return camera_look_at_point.global_position
	
func get_current_camera_mode() -> Mode:
	return camera_mode
	
func _input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if camera_mode == Mode.Third_Person:
			handle_third_person_mouse_event(event)
		elif camera_mode == Mode.First_Person:
			handle_first_person_mouse_event(event)
	
func handle_first_person_mouse_event(event):
	if event is InputEventMouseMotion:
		var mouse_position: Vector2 = get_viewport().get_mouse_position()
		spring_arm.rotation.x -= event.relative.y * 0.005
		spring_arm.rotation.y -= event.relative.x * 0.005
		
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, -0.8, 0.8)	
		
		
func handle_third_person_mouse_event(event):
	if event is InputEventMouseMotion:
		var mouse_position: Vector2 = get_viewport().get_mouse_position()
		spring_arm.rotation.x += event.relative.y * 0.005
		spring_arm.rotation.y += event.relative.x * 0.005
		
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, -1, 0)		
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			spring_arm.spring_length = lerp(spring_arm.spring_length, spring_arm.spring_length + 2, 0.05)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			spring_arm.spring_length = lerp(spring_arm.spring_length, spring_arm.spring_length - 2, 0.05)			
	
		spring_arm.spring_length = clamp(spring_arm.spring_length, 3, 10)	
	
func _process(delta):
	self.global_position = look_at_node.global_position
	if camera_mode == Mode.Third_Person:
		camera.look_at(look_at_node.global_position)
 
