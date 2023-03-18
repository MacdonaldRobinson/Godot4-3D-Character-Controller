extends AnimationTree
class_name AnimationStateController

enum AnimationState {
	Crouch,
	Stand
}

var current_animation_state: AnimationState = AnimationState.Stand

func _process(event):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction: Vector3 = (owner.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	play_animation_state(direction)

func play_animation_state(direction: Vector3):
	
	var new_animation_state: AnimationState = current_animation_state
	
	if Input.is_action_just_pressed("crouch"):
		if current_animation_state == AnimationState.Crouch:
			new_animation_state = AnimationState.Stand
		else:
			new_animation_state = AnimationState.Crouch
			
	if Input.is_action_just_pressed("attack1"):
		var attack_path: String = "parameters/attacks/transition_request"
		set(attack_path, "attack1")
		
		var direction_attack_path: String = "parameters/direction_attack/request"
		set(direction_attack_path, 1)

			
	var new_state_name = AnimationState.keys()[new_animation_state].to_lower()
	
	var state_path: String = "parameters/current_state/transition_request"
	var state_blend_path: String = "parameters/"+new_state_name+"/blend_position"
	
	current_animation_state = new_animation_state
	
	var current_blend_position = get(state_blend_path)
	var new_blend_position = Vector2(direction.z, direction.x)
	
	set(state_path, new_state_name)
	
	if Input.is_action_just_pressed("jump"):
		state_blend_path = "parameters/stand_jump/request"
		set(state_blend_path, true)
	else:
		set(state_blend_path, lerp(current_blend_position, new_blend_position, 0.1))
