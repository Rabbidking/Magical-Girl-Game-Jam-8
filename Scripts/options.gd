extends Node

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/boss_select.tscn")


