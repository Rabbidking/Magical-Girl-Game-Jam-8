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
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)
	
func save():
	var save_dict = {
		"boss_1_def": State.boss_1_def,
		"boss_2_def": State.boss_2_def,
		"boss_3_def": State.boss_3_def,
		"boss_4_def": State.boss_4_def,
		"slot_array_def": State.slot_array_def
	}

	return save_dict

func _on_load_pressed():
	load_game()
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		print(node_data)
		State.boss_1_def = node_data["boss_1_def"]
		State.boss_2_def = node_data["boss_2_def"]
		State.boss_3_def = node_data["boss_3_def"]
		State.boss_4_def = node_data["boss_4_def"]
		State.slot_array_def = node_data["slot_array_def"]


func _on_quit_pressed():
	get_tree().quit()


func _on_boss_gui_cockatrice_select():
	get_tree().change_scene_to_file("res://Scenes/battle.tscn")
func _on_boss_gui_harpy_select():
	get_tree().change_scene_to_file("res://Scenes/battle4.tscn")
func _on_boss_gui_lamia_select():
	get_tree().change_scene_to_file("res://Scenes/battle3.tscn")
func _on_boss_gui_lizardwoman_select():
	get_tree().change_scene_to_file("res://Scenes/battle2.tscn")
func _on_boss_gui_open_shop():
	pass # Replace with function body.
	
func _on_boss_gui_load_select():
	load_game()
	print(State.boss_1_def)
	print(State.boss_2_def)
	print(State.boss_3_def)
	print(State.boss_4_def)
	
func _on_boss_gui_option_select():
	pass # Replace with function body.


func _on_inventory_gui_save_items():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)
