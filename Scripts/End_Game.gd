extends Node2D


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func _input(event):
	if event.is_action_pressed("Select"):
		get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
