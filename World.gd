extends Node3D

@onready var camera_controller: CameraController = $CameraController
@onready var player = $Player
	

func _process(delta):
	if player:
		var player_look_at_point = player.get_look_at_point()	
		camera_controller.set_look_at_point(player_look_at_point);	

	
func _on_settings_panel_camera_control_option_changed(mode):
	camera_controller.set_camera_mode(mode)
