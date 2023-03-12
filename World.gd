extends Node3D

@onready var camera_controller: CameraController = $CameraController

func _on_settings_panel_camera_control_option_changed(mode):
	camera_controller.set_camera_mode(mode)
