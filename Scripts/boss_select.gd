extends Control

signal load_file1
signal load_file2
signal load_file3
signal load_file4
signal save_file

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

func _on_boss_gui_option_select():
	pass # Replace with function body.
func _on_inventory_gui_save_items():
	pass

func _on_inventory_gui_save_items_1():
	var save_game = FileAccess.open("user://savegame1.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)
	print("save_thus2")
	save_file.emit()

func _on_inventory_gui_save_items_2():
	var save_game = FileAccess.open("user://savegame2.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)
	save_file.emit()

func _on_inventory_gui_save_items_3():
	var save_game = FileAccess.open("user://savegame3.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)
	save_file.emit()

func _on_inventory_gui_save_items_4():
	var save_game = FileAccess.open("user://savegame4.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)
	save_file.emit()


func _on_save_gui_load_slot_1():
	if not FileAccess.file_exists("user://savegame1.save"):
		return
		
	var save_game = FileAccess.open("user://savegame1.save", FileAccess.READ)
	
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
		load_file1.emit()

func _on_save_gui_load_slot_2():
	if not FileAccess.file_exists("user://savegame2.save"):
		return
		
	var save_game = FileAccess.open("user://savegame2.save", FileAccess.READ)
	
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
		load_file2.emit()

func _on_save_gui_load_slot_3():
	if not FileAccess.file_exists("user://savegame3.save"):
		return
		
	var save_game = FileAccess.open("user://savegame3.save", FileAccess.READ)
	
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
		load_file3.emit()

func _on_save_gui_load_slot_4():
	if not FileAccess.file_exists("user://savegame4.save"):
		return
		
	var save_game = FileAccess.open("user://savegame4.save", FileAccess.READ)
	
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
		load_file4.emit()
