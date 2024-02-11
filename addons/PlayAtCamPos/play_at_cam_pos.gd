@tool
extends Control

@export var play_here_button: Button

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
