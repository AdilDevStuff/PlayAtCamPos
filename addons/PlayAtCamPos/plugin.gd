@tool
extends EditorPlugin

var cam
var play_here_btn
var player

var follow_rotation: bool = false
const PLAY_HERE_BUTTON = preload("res://addons/PlayAtCamPos/play_here_button.tscn")

func _enter_tree():
	set_project_setting()
	cam = get_editor_interface().get_editor_viewport_3d().get_camera_3d()
	
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
	for child in get_editor_interface().get_edited_scene_root().get_children():
		if child is CharacterBody3D:
			player = child

func get_camera_position():
	return cam.position

func get_camera_transform():
	return cam.transform

func set_project_setting():
	ProjectSettings.set("PlayAtCameraPos/follow_rotation", false)
	ProjectSettings.add_property_info(
		{
			"name": "PlayAtCameraPos/follow_rotation",
			"type" : TYPE_BOOL
		})

func get_project_setting():
	follow_rotation = ProjectSettings.get_setting("PlayAtCameraPos/follow_rotation")

func _on_button_pressed():
	get_target()
	match follow_rotation:
		true:
			player.transform = get_camera_transform()
		false:
			player.position = get_camera_position()
			player.rotation = Vector3.ZERO
	get_editor_interface().play_current_scene()
