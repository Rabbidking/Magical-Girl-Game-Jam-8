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
	cursor.cursor_enabled()
	update()
	$Timer.start()
	
	
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
	cursor.boss_offset()
	
	
func _on_boss_slot_cursor_selected():
	cockatrice_select.emit()
func _on_boss_slot_2_cursor_selected():
	lizardwoman_select.emit()
func _on_boss_slot_3_cursor_selected():
	lamia_select.emit()
func _on_boss_slot_4_cursor_selected():
	harpy_select.emit()
func _on_boss_slot_5_cursor_selected():
	open_shop.emit()
func _on_boss_slot_6_cursor_selected():
	option_select.emit()
func _on_boss_slot_7_cursor_selected():
	save_select.emit()
func _on_boss_slot_8_cursor_selected():
	load_select.emit()


func _on_boss_slot_button_pressed():
	_on_boss_slot_cursor_selected()
func _on_boss_slot_2_button_pressed():
	_on_boss_slot_2_cursor_selected()
func _on_boss_slot_3_button_pressed():
	_on_boss_slot_3_cursor_selected()
func _on_boss_slot_4_button_pressed():
	_on_boss_slot_4_cursor_selected()
func _on_boss_slot_5_button_pressed():
	_on_boss_slot_5_cursor_selected()
func _on_boss_slot_6_button_pressed():
	_on_boss_slot_6_cursor_selected()
func _on_boss_slot_7_button_pressed():
	_on_boss_slot_7_cursor_selected()
func _on_boss_slot_8_button_pressed():
	_on_boss_slot_8_cursor_selected()
