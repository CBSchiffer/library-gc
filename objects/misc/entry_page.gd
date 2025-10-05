extends StaticBody3D

@export var readable_id: String = "1"
@onready var readable_ui : CanvasLayer = %ReadableUI


func interact() -> void:
	readable_ui.show_readable(readable_id)

func interact_text() -> String:
	return "Read Letter (E)"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("interactable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
