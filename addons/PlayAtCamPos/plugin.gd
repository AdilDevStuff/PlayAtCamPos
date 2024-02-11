@tool
extends EditorPlugin

var cam
var target
var play_here_btn
var warning_dialogue

var follow_rotation: bool = false
var target_group: String = ""

const PLAY_HERE_BUTTON = preload("res://addons/PlayAtCamPos/play_here_button.tscn")
const WARNING_DIALOGUE = preload("res://addons/PlayAtCamPos/warning_dialogue.tscn")

func _enter_tree():
	set_project_setting()

	cam = get_editor_interface().get_editor_viewport_3d().get_camera_3d()
	
	# Instance the play button
	play_here_btn = PLAY_HERE_BUTTON.instantiate()
	play_here_btn.pressed.connect(_on_button_pressed)
	
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, play_here_btn)

func _process(delta):
	get_project_setting()
	get_camera_transform()
	get_camera_position()

func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, play_here_btn)

func get_target():
	for child in get_tree().edited_scene_root.get_children():
		if child is CharacterBody3D:
			target = child
		else:
			target = null
	if target == null:
		printerr("Target not found! Make sure you have a CharacterBody3D in the current scene")

func get_camera_position():
	return cam.position

func get_camera_transform():
	return cam.transform

func set_project_setting():
	ProjectSettings.set("PlayAtCamPos/follow_rotation", false)
	ProjectSettings.set("PlayAtCamPos/target_group", "")
	ProjectSettings.add_property_info(
		{
			"follow_rotation": "PlayAtCamPos/follow_rotation",
			"type_bool" : TYPE_BOOL,
			"target_group": "PlayAtCamPos/target_group",
			"type_string" : TYPE_STRING
		})

func get_project_setting():
	follow_rotation = ProjectSettings.get_setting("PlayAtCamPos/follow_rotation")
	target_group = ProjectSettings.get_setting("PlayAtCamPos/target_group")

func _on_button_pressed():
	get_target()
	if target != null:
		match follow_rotation:
			true:
				target.transform = get_camera_transform()
			false:
				target.position = get_camera_position()
				target.rotation = Vector3.ZERO
		get_editor_interface().play_current_scene()
