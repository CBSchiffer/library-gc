extends StaticBody3D

func interact() -> void:
	print_debug("BUTTON PRESSED!")

func interact_text() -> String:
	return "Press Button (E)"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("interactable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
