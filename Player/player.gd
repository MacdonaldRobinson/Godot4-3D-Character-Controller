extends CharacterBody3D

@export var camera_controller: CameraController
@onready var character: Character = $OldMage

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _input(event):
	if Input.is_action_just_pressed("ToggleMouseCapture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED		

func get_look_at_point()-> Vector3:
	return character.get_look_at_point()
	
func get_weapon_point()-> Vector3:
	return character.get_weapon_point()	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var camera_look_at_point = camera_controller.get_camera_look_at_point()
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		var animation_tree: AnimationStateController = character.get_animation_tree()
		var root_motion = animation_tree.get_root_motion_position()
		
		var look_at_point = camera_look_at_point
		look_at_point.y = self.global_position.y
		
		self.look_at(look_at_point)
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
