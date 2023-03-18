extends Node3D
class_name Character

@onready var animation_tree: AnimationStateController = $AnimationTree
@onready var look_at_point: Node3D = $Body/Armature/GeneralSkeleton/LookAtBoneAttachment/LookAtPoint
@onready var weapon_point: Node3D = $Body/Armature/GeneralSkeleton/WeaponBoneAttachment/WeaponPoint

func get_animation_tree() -> AnimationStateController:
	return animation_tree
	
func get_look_at_point()->Vector3:
	return look_at_point.global_position

func get_weapon_point()->Vector3:
	return weapon_point.global_position
