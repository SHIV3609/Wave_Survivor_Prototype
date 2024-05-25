extends CharacterBody3D

@onready var head = $Head

@export_group("Controller")
@export var sensitivity: float = 0.2
@export var speed: int = 20
@export var jump_gravity: int = 15
@export var fall_gravity: int = 30
@export var jump_velocity: int = 10000

var direction

func _ready():
	#Setting mouse_mode to capture
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta):
	
	#Applying movement function
	movement()

func apply_gravity():
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y -= jump_gravity
		else:
			velocity.y -= fall_gravity

func movement():
	#Resetting direction every frame
	direction = Vector3.ZERO
	
	#Calclating direction
	if Input.is_action_pressed("forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("right"):
		direction += transform.basis.x
	
	direction = direction.normalized()
	
	#Calculating velocity
	velocity = direction * speed
	
	#Applying gravity using apply_gravity function
	apply_gravity()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	
	#Applying velocity to movement
	move_and_slide()

func _input(event):
	
	#Rotating Player head & body
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, -60, 60)
	
	#Pause/play option
	if Input.is_action_just_pressed("ui_cancel"):
		match Input.mouse_mode:
			Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func jump():
	velocity.y = jump_velocity
