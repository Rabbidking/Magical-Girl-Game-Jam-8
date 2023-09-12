extends Control

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/boss_select.tscn")

func _input(event):
	if event.is_action_pressed("Select"):
		get_tree().change_scene_to_file("res://Scenes/boss_select.tscn")
