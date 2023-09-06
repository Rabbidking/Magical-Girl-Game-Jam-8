extends Control


func _on_boss_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/battle.tscn")


func _on_boss_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/battle2.tscn")


func _on_boss_3_pressed():
	get_tree().change_scene_to_file("res://Scenes/battle3.tscn")


func _on_boss_4_pressed():
	get_tree().change_scene_to_file("res://Scenes/battle4.tscn")


func _on_options_pressed():
	pass # Replace with function body.


func _on_save_pressed():
	pass # Replace with function body.


func _on_load_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
