@tool
extends Control

@export var play_here_button: Button

@onready var Global = preload("res://addons/PlayAtCamPos/Global.gd").new()
@onready var group_name: LineEdit = %GroupName

func _process(delta: float) -> void:
	Global.target_group = group_name.text

func _on_settings_btn_pressed():
	$SettingsWindow.popup_centered()

func _on_settings_window_close_requested():
	$SettingsWindow.hide()

func _on_save_btn_pressed():
	$SettingsWindow.hide()

func _on_follow_cam_rot_btn_toggled(toggled_on):
	if toggled_on:
		Global.follow_rotation = true
	else:
		Global.follow_rotation = false

func _on_group_name_text_submitted(new_text: String) -> void:
	group_name.release_focus()
