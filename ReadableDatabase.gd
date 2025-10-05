extends Node

var data := {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = _load_csv("res://readables.csv")

func _load_csv(path: String) -> Dictionary:
	var f := FileAccess.open(path, FileAccess.READ)
	if f == null:
		push_error("Could not open: %s" % path)
		return {}
	var rows: Array[PackedStringArray] = []
	while !f.eof_reached():
		var line := f.get_csv_line()           # <- handles quotes + commas
		if line.size() == 1 and line[0].strip_edges() == "":
			continue
		rows.append(line)

	if rows.is_empty():
		return {}

	var headers := rows[0]
	var out := {}
	for i in range(1, rows.size()):
		var cols := rows[i]
		var entry := {}
		for j in range(headers.size()):
			var key := headers[j]
			var val := String(cols[j]) if (j < cols.size()) else ""
			entry[key] = val
		if entry.has("id"):
			out[entry["id"]] = entry
	return out

func get_entry(id: String) -> Dictionary:
	return data.get(id, {})

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
