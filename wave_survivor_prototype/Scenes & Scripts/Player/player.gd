extends CharacterBody3D

@export_group("Movement")
@export var speed: int = 300
@export var gravity: int = 98
@export var jump_velocity: int = 30

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		match Input.mouse_mode:
			Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
