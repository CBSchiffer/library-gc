extends Node3D

var sens = 0.5;

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;

func _input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		return
	if event is InputEventMouseMotion:
		get_parent().rotate_y(deg_to_rad(-event.relative.x * sens));
		rotate_x(deg_to_rad(-event.relative.y * sens));
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90));
