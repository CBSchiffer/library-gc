extends Node
class_name Interactable
func get_interact_text() -> String:
	return "";
	
func interact() -> void:
	push_warning("Interactable object with no interact function!");
