extends CharacterBody3D

@onready var Camera: Camera3D = %MainCamera
var CameraRotation = Vector2(0.0,0.0)
var MouseSensitivity = 0.001

var Speed = 5.0
#const JUMP_VELOCITY = 4.5

@export var Jump_Peak_Time: float = 0
@export var Jump_Fall_Time: float = 0
@export var Jump_Height: float = 0
@export var Jump_Distance: float = 0
var Jump_Velocity: float

var Start_Time = 0
var End_Time = 0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var Jump_Gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var Fall_Gravity: float = -5.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Establish_Speed()

func Establish_Speed()->void:
	Jump_Gravity = (2*Jump_Height)/ pow(Jump_Peak_Time,2)
	Fall_Gravity = (2*Jump_Height)/ pow(Jump_Fall_Time,2)
	Jump_Velocity = ((Jump_Gravity)*(Jump_Peak_Time))
	Speed = Jump_Distance/(Jump_Peak_Time+Jump_Fall_Time)
	
	print("Fall Gravity: ", Fall_Gravity)
	print("Jump Gravity: ", Jump_Gravity)
	print("Jump Velocity: ", Jump_Velocity)
	print("Speed: ", Speed)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if velocity.y>0:
			velocity.y -= Jump_Gravity * delta
		else:
			velocity.y -= Fall_Gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = Jump_Velocity


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * Speed
		velocity.z = direction.z * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
		velocity.z = move_toward(velocity.z, 0, Speed)

	move_and_slide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if event is InputEventMouseMotion:
		var MouseEvent = event.relative * MouseSensitivity
		CameraLook(MouseEvent)

func CameraLook(Movement: Vector2):
	CameraRotation += Movement
	
	transform.basis = Basis()
	Camera.transform.basis = Basis()
	
	rotate_object_local(Vector3(0,1,0),-CameraRotation.x) # first rotate in Y
	Camera.rotate_object_local(Vector3(1,0,0), -CameraRotation.y) # then rotate in X
	CameraRotation.y = clamp(CameraRotation.y,-1.5,1.2)
