@tool
extends EditorPlugin

# ---------- VARIABLES ---------- #

# Private
var cam
var target
var play_here_btn
var reset_pos_button
var user_interface
var warning_dialogue

# Normal
var target_group: String = ""

# Bools
var follow_rotation: bool = false

# Const
const PLAY_AT_CAMERA_POS_UI = preload("res://addons/PlayAtCamPos/scenes/Button.tscn")
const WARNING_DIALOGUE = preload("res://addons/PlayAtCamPos/scenes/warning_dialogue.tscn")

@onready var Global = preload("res://addons/PlayAtCamPos/Global.gd")

# ---------- FUNCTIONS ---------- #

#region Built-in Functions
func _enter_tree():
	# Instantiate Warning Dialogue
	warning_dialogue = WARNING_DIALOGUE.instantiate()
	add_child(warning_dialogue)
	
	# Get Editor Viewport Camera
	cam = get_editor_interface().get_editor_viewport_3d().get_camera_3d()
	
	# Instance The Play Button
	user_interface = PLAY_AT_CAMERA_POS_UI.instantiate()
	play_here_btn = user_interface.get_node("PanelContainer/HBoxContainer/PlayHereButton")
	play_here_btn.pressed.connect(_on_button_pressed)
	
	reset_pos_button = user_interface.get_node("SettingsWindow/PanelContainer/CenterContainer/Settings/ResetPosBtn")
	reset_pos_button.pressed.connect(_on_reset_pos_button_pressed)

	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, user_interface)

func _process(delta):
	get_target()
	get_camera_transform()
	get_camera_position()

func _exit_tree():
	Global.follow_rotation = false
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, user_interface)
#endregion

#region Custom Functions
func get_target(): # Get the target object (Any body with a specifed group)
	target = null
	for child in get_tree().edited_scene_root.get_children():
		if child.is_in_group(Global.target_group):
			target = child

func get_camera_position():
	return cam.position

func get_camera_transform():
	return cam.transform

func show_warnings():
	if target == null:
		warning_dialogue.popup_centered()
#endregion

#region Signal Functions
func _on_button_pressed():
	if target != null:
		if Global.follow_rotation:
			target.transform = get_camera_transform()
		else:
			target.position = get_camera_position()
			target.rotation = Vector3.ZERO
		get_editor_interface().play_current_scene()
	else:
		show_warnings()

func _on_reset_pos_button_pressed():
	if target:
		target.position = Vector3(0,2,0)
		target.rotation = Vector3.ZERO
	else: push_error("Target not found! Make sure to set the group in the settings")
#endregion

