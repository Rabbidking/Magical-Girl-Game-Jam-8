extends Control

signal opened
signal closed

signal save_slot1
signal save_slot2
signal save_slot3
signal save_slot4
signal load_slot1
signal load_slot2
signal load_slot3
signal load_slot4

var save_mode = false
var load_mode = false
var is_open: bool = false

@onready var save: Savefile = preload("res://Save Files/save_file_menu.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var slot1: Save_Collection = preload("res://Save Files/save_slot1.tres")
@onready var slot2: Save_Collection = preload("res://Save Files/save_slot2.tres")
@onready var slot3: Save_Collection = preload("res://Save Files/save_slot3.tres")
@onready var slot4: Save_Collection = preload("res://Save Files/save_slot4.tres")
@onready var cursor = $Cursor

func open():
	visible = true
	is_open = true
	if save_mode == true:
		$NinePatchRect/Label.text = "SAVE"
		$NinePatchRect/GridContainer/Save_Slot.change_to_save()
		$NinePatchRect/GridContainer/Save_Slot2.change_to_save()
		$NinePatchRect/GridContainer/Save_Slot3.change_to_save()
		$NinePatchRect/GridContainer/Save_Slot4.change_to_save()
	elif load_mode == true:
		$NinePatchRect/Label.text = "LOAD"
		$NinePatchRect/GridContainer/Save_Slot.change_to_load()
		$NinePatchRect/GridContainer/Save_Slot2.change_to_load()
		$NinePatchRect/GridContainer/Save_Slot3.change_to_load()
		$NinePatchRect/GridContainer/Save_Slot4.change_to_load()
	$Timer.start()
	opened.emit()

func close():
	visible = false
	is_open = false 
	save_mode = false
	load_mode = false
	cursor.cursor_disabled()
	closed.emit()

		
func _on_save_slot_cursor_selected():
	if save_mode == true:
		save_slot1.emit()
	elif load_mode == true:
		load_slot1.emit()
func _on_save_slot_2_cursor_selected():
	if save_mode == true:
		save_slot2.emit()
	elif load_mode == true:
		load_slot2.emit()
func _on_save_slot_3_cursor_selected():
	if save_mode == true:
		save_slot3.emit()
	elif load_mode == true:
		load_slot3.emit()
func _on_save_slot_4_cursor_selected():
	if save_mode == true:
		save_slot4.emit()
	elif load_mode == true:
		load_slot4.emit()


func _on_boss_gui_save_select():
	save_mode = true
	open()

func _on_boss_gui_load_select():
	load_mode = true
	open()


func _on_inventory_gui_loaded_items():
	close()
func _on_boss_select_save_file():
	close()


func _on_save_slot_button_pressed():
	if save_mode == true:
		save_slot1.emit()
	elif load_mode == true:
		load_slot1.emit()
func _on_save_slot_2_button_pressed():
	if save_mode == true:
		save_slot2.emit()
	elif load_mode == true:
		load_slot2.emit()
func _on_save_slot_3_button_pressed():
	if save_mode == true:
		save_slot3.emit()
	elif load_mode == true:
		load_slot3.emit()
func _on_save_slot_4_button_pressed():
	if save_mode == true:
		save_slot4.emit()
	elif load_mode == true:
		load_slot4.emit()


func _on_timer_timeout():
	cursor.cursor_enabled()
