@tool
extends EditorPlugin

var cam
var play_here_btn
var player

const PLAY_HERE_BUTTON = preload("res://addons/playatcurrentposition/play_here_button.tscn")

func _enter_tree():
	play_here_btn = PLAY_HERE_BUTTON.instantiate()
	play_here_btn.pressed.connect(func():
		get_target()
		player.position = get_camera_position()
		get_editor_interface().play_current_scene())
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, play_here_btn)

func _process(delta):
	get_camera_position()

func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, play_here_btn)

func get_target():
	for child in get_editor_interface().get_edited_scene_root().get_children():
		if child is CharacterBody3D:
			print(child)
			player = child

func get_camera_position():
	cam = get_editor_interface().get_editor_viewport_3d().get_camera_3d()
	return cam.position
