extends Control

signal open_inventory
signal open_shop
signal closed
signal cockatrice_select
signal lizardwoman_select
signal harpy_select
signal lamia_select
signal option_select
signal save_select
signal load_select

var is_open: bool = false

@onready var inventory = preload("res://Scenes/inventory_gui.tscn")
@onready var boss_menu: Boss_Menu = preload("res://Boss Menu/boss_select_menu.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var cockatrice: Boss_Options = preload("res://Boss Menu/Cockatrice.tres")
@onready var lizardwoman: Boss_Options = preload("res://Boss Menu/Lizardwoman.tres")
@onready var harpy: Boss_Options = preload("res://Boss Menu/Harpy.tres")
@onready var lamia: Boss_Options = preload("res://Boss Menu/Lamia.tres")
@onready var shop: Boss_Options = preload("res://Boss Menu/Shop.tres")
@onready var option: Boss_Options = preload("res://Boss Menu/Options.tres")
@onready var save: Boss_Options = preload("res://Boss Menu/Save.tres")
@onready var load: Boss_Options = preload("res://Boss Menu/Load.tres")
@onready var cursor = $Cursor

func _ready():
	cursor.boss_offset()
	update()
	$Timer.start()
	boss_update()
	$NinePatchRect/GridContainer/Boss_Slot5.resize_slot()
	$NinePatchRect/GridContainer/Boss_Slot6.resize_slot()
	$NinePatchRect/GridContainer/Boss_Slot7.resize_slot()
	$NinePatchRect/GridContainer/Boss_Slot8.resize_slot()
	$NinePatchRect/GridContainer/Boss_Slot9.resize_slot()
	
func update():
	for i in range(min(boss_menu.boss_options.size(), slots.size())):
		slots[i].update(boss_menu.boss_options[i])
	
func open():
	visible = true
	is_open = true
	$Timer.start()
	
	
func close():
	visible = false
	is_open = false 
	cursor.cursor_disabled()
	closed.emit()
	
	
func _on_battle_slot_2_cursor_selected():
	open_shop.emit()
	close()
	
	
func _on_timer_timeout():
	cursor.cursor_enabled()

	
	
func _on_boss_slot_cursor_selected():
	if State.boss_1_def == false:
		cockatrice_select.emit()
func _on_boss_slot_2_cursor_selected():
	if State.boss_2_def == false:
		lizardwoman_select.emit()
func _on_boss_slot_3_cursor_selected():
	if State.boss_3_def == false:
		harpy_select.emit()
func _on_boss_slot_4_cursor_selected():
	if State.boss_4_def == false:
		lamia_select.emit()
func _on_boss_slot_5_cursor_selected():
	open_shop.emit()
	cursor.cursor_disabled()
func _on_boss_slot_6_cursor_selected():
	get_tree().change_scene_to_file("res://Scenes/options.tscn")
func _on_boss_slot_7_cursor_selected():
	save_select.emit()
	cursor.cursor_disabled()
func _on_boss_slot_8_cursor_selected():
	load_select.emit()
	cursor.cursor_disabled()
func _on_boss_slot_9_cursor_selected():
	get_tree().change_scene_to_file("res://Scenes/help.tscn")


func _on_boss_slot_button_pressed():
	if State.boss_1_def == false:
		_on_boss_slot_cursor_selected()
func _on_boss_slot_2_button_pressed():
	if State.boss_2_def == false:
		_on_boss_slot_2_cursor_selected()
func _on_boss_slot_3_button_pressed():
	if State.boss_3_def == false:
		_on_boss_slot_3_cursor_selected()
func _on_boss_slot_4_button_pressed():
	if State.boss_4_def == false:
		_on_boss_slot_4_cursor_selected()
func _on_boss_slot_5_button_pressed():
	_on_boss_slot_5_cursor_selected()
func _on_boss_slot_6_button_pressed():
	_on_boss_slot_6_cursor_selected()
func _on_boss_slot_7_button_pressed():
	_on_boss_slot_7_cursor_selected()
func _on_boss_slot_8_button_pressed():
	_on_boss_slot_8_cursor_selected()
func _on_boss_slot_9_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/help.tscn")

func _on_shop_gui_closed():
	$Timer.start()
func _on_save_gui_closed():
	$Timer.start()

func boss_update():
	print("fade")
	if State.boss_1_def == true:
		$NinePatchRect/GridContainer/Boss_Slot/Cockatrice_Fade.visible = true
		$NinePatchRect/GridContainer/Boss_Slot.disable_button()
	elif State.boss_1_def == false:
		$NinePatchRect/GridContainer/Boss_Slot/Cockatrice_Fade.visible = false
		$NinePatchRect/GridContainer/Boss_Slot.enable_button()
	if State.boss_2_def == true:
		$NinePatchRect/GridContainer/Boss_Slot2/LizardWoman_Fade.visible = true
		$NinePatchRect/GridContainer/Boss_Slot2.disable_button()
	elif State.boss_2_def == false:
		$NinePatchRect/GridContainer/Boss_Slot2/LizardWoman_Fade.visible = false
		$NinePatchRect/GridContainer/Boss_Slot2.enable_button()
	if State.boss_3_def == true:
		$NinePatchRect/GridContainer/Boss_Slot3/Harpy_Fade.visible = true
		$NinePatchRect/GridContainer/Boss_Slot3.disable_button()
	elif State.boss_3_def == false:
		$NinePatchRect/GridContainer/Boss_Slot3/Harpy_Fade.visible = false
		$NinePatchRect/GridContainer/Boss_Slot3.enable_button()
	if State.boss_4_def == true:
		$NinePatchRect/GridContainer/Boss_Slot4/Lamia_Fade.visible = true
		$NinePatchRect/GridContainer/Boss_Slot4.disable_button()
	elif State.boss_4_def == false:
		$NinePatchRect/GridContainer/Boss_Slot4/Lamia_Fade.visible = false
		$NinePatchRect/GridContainer/Boss_Slot4.enable_button()


func _on_save_gui_load_slot_1():
	boss_update()
func _on_save_gui_load_slot_2():
	boss_update()
func _on_save_gui_load_slot_3():
	boss_update()
func _on_save_gui_load_slot_4():
	boss_update()






