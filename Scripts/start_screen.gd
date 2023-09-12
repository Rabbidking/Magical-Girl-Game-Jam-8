extends Node2D

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/help.tscn")
	
func _input(event):
	if event.is_action_pressed("Exit"):
		get_tree().quit()
	if event.is_action_pressed("Select"):
		get_tree().change_scene_to_file("res://Scenes/help.tscn")
