@tool
extends Node

var target

var target_group: String = ""
static var follow_rotation: bool = false

func reset_target_position(target):
	target.position = Vector3.ZERO
