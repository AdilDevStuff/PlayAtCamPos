@tool
extends EditorPlugin

# ---------- VARIABLES ---------- #

# Private
var cam
var target
var play_here_btn
var warning_dialogue

# Normal
var target_group: String = ""

# Bools
var follow_rotation: bool = false

# Const
const BUTTON = preload("res://addons/PlayAtCamPos/Button.tscn")

# ---------- FUNCTIONS ---------- #

#region Built-in Functions
func _enter_tree():
	add_project_setting()

	cam = get_editor_interface().get_editor_viewport_3d().get_camera_3d()
	
	# Instance the play button
	play_here_btn = BUTTON.instantiate()
	#play_here_btn.pressed.connect(_on_button_pressed)
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, play_here_btn)


func _process(delta):
	get_project_setting()
	get_camera_transform()
	get_camera_position()


func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, play_here_btn)
#endregion


#region Custom Functions
func get_target(): # Get the target object (Any body with a specifed group)
	target = null
	for child in get_tree().edited_scene_root.get_children():
		if child is CharacterBody3D:
			target = child

func get_camera_position():
	return cam.position


func get_camera_transform():
	return cam.transform


func add_project_setting():
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


func show_warnings():
	if target == null:
		play_here_btn.disabled = true
		play_here_btn.text = "No Target"
		printerr("Target not found! Make sure you have a CharacterBody3D in the current scene")
	else:
		play_here_btn.disabled = false
		play_here_btn.text = "Play Here"
#endregion


#region Signal Functions
#func _on_button_pressed():
	#get_target()
	#if target != null:
		#match follow_rotation:
			#true:
				#target.transform = get_camera_transform()
			#false:
				#target.position = get_camera_position()
				#target.rotation = Vector3.ZERO
		#get_editor_interface().play_current_scene()

#endregion
