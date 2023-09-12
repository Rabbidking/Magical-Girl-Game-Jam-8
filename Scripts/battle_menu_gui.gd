extends Control

signal open_inventory
signal open_shop
signal closed

var is_open: bool = false

@onready var inventory = preload("res://Scenes/inventory_gui.tscn")
@onready var battle_menu: Battle_Menu = preload("res://Battle Menu/player_battle_menu.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var stuff: Battle_Options = preload("res://Battle Menu/Option1.tres")
@onready var stuff1: Battle_Options = preload("res://Battle Menu/Option2.tres")
@onready var cursor = $Cursor

func _ready():
	cursor.cursor_enabled()
	update()
	
	
func update():
	for i in range(min(battle_menu.battle_options.size(), slots.size())):
		slots[i].update(battle_menu.battle_options[i])
	
func open():
	visible = true
	is_open = true
	$Timer.start()
	
	
func close():
	visible = false
	is_open = false 
	cursor.cursor_disabled()
	closed.emit()
	
	
func _on_canvas_layer_add_item():
	battle_menu.battle_options[0] = stuff
	print(battle_menu.battle_options[0])
	update()
	
	
func _on_battle_slot_cursor_selected():
	open_inventory.emit()
	close()
	
	
func _on_battle_slot_2_cursor_selected():
	open_shop.emit()
	close()
	
	
func _on_timer_timeout():
	cursor.cursor_enabled()
	
