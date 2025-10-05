extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var cam : Camera3D = $head/Camera3D
@onready var eye : RayCast3D = $head/Camera3D/RayCast3D
@onready var prompt : Label = $CanvasLayer/Control/PromptLabel
@onready var interactable : Object = null;
@onready var readable_ui : CanvasLayer = %ReadableUI

func _ready() -> void:
	prompt.visible = false

func _process(delta: float) -> void:
	if readable_ui.visible:
		return
	eye.force_raycast_update()
	if not eye.is_colliding():
		_clear_prompt()
		return
	
	var col := eye.get_collider()
	if not (col and col.is_in_group("interactable")):
		_clear_prompt()
		return
		
	var hit_pos: Vector3 = eye.get_collision_point()
	if cam.is_position_behind(hit_pos):
		_clear_prompt()
		return
	
	var screen_pos: Vector2 = cam.unproject_position(hit_pos)
	var txt := ""
	if col.has_method("interact_text"):
		txt = col.interact_text()
		interactable = col
	elif "interact_text" in col and typeof(col.interact_text) == TYPE_STRING:
		txt = col.interact_text
	else:
		txt = ""
	
	if txt == "":
		_clear_prompt()
		return
	
	prompt.text = txt
	prompt.visible = true
	
	var offset := Vector2(12, -24)
	prompt.position = screen_pos + offset
	
	if Input.is_action_just_pressed("interact") and interactable != null and interactable.has_method("interact"):
		interactable.interact()

		

	

func _clear_prompt() -> void:
	if prompt.visible:
		prompt.visible = false
		prompt.text = ""
		interactable = null

func _physics_process(delta: float) -> void:
	if readable_ui.visible:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
