extends Control
class_name SettingsPanel

@export var camera_controller: CameraController

@onready var camera_control_options: OptionButton = $VBoxContainer/CameraControlOptions

signal CameraControlOptionChanged(mode:CameraController.Mode)

func _ready():
	for mode in CameraController.Mode:
		camera_control_options.add_item(mode)

	var current_camera_mode: CameraController.Mode = camera_controller.get_current_camera_mode()
	camera_control_options.select(current_camera_mode)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_camera_control_options_item_selected(index):	
	CameraControlOptionChanged.emit(index)
