extends Button

signal cursor_selected()

func cursor_select() -> void:
	print(name)
	emit_signal("cursor_selected")

func _on_button_pressed():
	print(name)
	emit_signal("button_pressed")
