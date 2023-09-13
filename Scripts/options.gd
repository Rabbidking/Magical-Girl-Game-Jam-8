extends Control

func _ready():
	$CanvasLayer/Control/VolumeContainer/Master.value = State.master_vol
	$CanvasLayer/Control/VolumeContainer/music.value = State.music_vol
	$CanvasLayer/Control/VolumeContainer/sfx.value = State.sfx_vol

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/boss_select.tscn")
