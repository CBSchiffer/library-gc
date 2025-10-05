extends CanvasLayer

@onready var title_label : RichTextLabel = $Panel/RightContainer/TitleLabel
@onready var author_label : RichTextLabel = $Panel/RightContainer/AuthorLabel
@onready var summary_text : RichTextLabel = $Panel/SummaryPanel/SummaryContainer/SummaryText
@onready var page_content : RichTextLabel = $Panel/Paper/PaperText


func show_readable(id: String) -> void:
	var entry = ReadableDatabase.get_entry(id)
	if entry.is_empty():
		return
	
	title_label.text = entry["title"]
	author_label.text = "By: " + entry["author"]
	summary_text.text = entry["summary"]
	page_content.text = entry["content"]
	
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and visible:
		visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
