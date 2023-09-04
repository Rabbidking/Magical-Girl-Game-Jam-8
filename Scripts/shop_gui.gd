extends Control

signal opened
signal closed

signal add_cupcake
signal add_knife
signal add_toaster
signal add_molotov
signal add_poison
signal add_spice
signal add_mitts
signal add_apron

var is_open: bool = false

@onready var shop: Shop = preload("res://Shop Inventory/shop_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var cupcake: Shop_Inventory = preload("res://Shop Inventory/Shop_Cupcake.tres")
@onready var knife: Shop_Inventory = preload("res://Shop Inventory/Shop_Kitchen Knife.tres")
@onready var toaster: Shop_Inventory = preload("res://Shop Inventory/Shop_Unstable Toaster.tres")
@onready var molotov: Shop_Inventory = preload("res://Shop Inventory/Shop_Molotov.tres")
@onready var poison: Shop_Inventory = preload("res://Shop Inventory/Shop_Rat Poison.tres")
@onready var spice: Shop_Inventory = preload("res://Shop Inventory/Shop_Spice.tres")
@onready var mitts: Shop_Inventory = preload("res://Shop Inventory/Shop_Oven Mitts.tres")
@onready var apron: Shop_Inventory = preload("res://Shop Inventory/Shop_Apron.tres")
@onready var cursor = $Cursor

func _ready():
	update()

func update():
	for i in range(min(shop.shop_items.size(), slots.size())):
		slots[i].update(shop.shop_items[i])
	
	
func open():
	visible = true
	is_open = true
	$Timer.start()
	opened.emit()
	
	
func close():
	visible = false
	is_open = false 
	cursor.cursor_disabled()
	closed.emit()
	
	
func _on_canvas_layer_add_item():
	shop.shop_items[0] = cupcake
	print(shop.shop_items[0])
	update()
	
	
func _on_battle_gui_open_shop():
	open()
	
func _on_shop_cursor_selected():
	open()
	
#Key Cursor Input
func _on_timer_timeout():
	cursor.cursor_enabled()
	cursor.shop_and_inventory_offset()
	
func _on_shop_slot_cursor_selected():
	add_cupcake.emit()
	
func _on_shop_slot_2_cursor_selected():
	add_knife.emit()
	
func _on_shop_slot_3_cursor_selected():
	add_toaster.emit()
	
func _on_shop_slot_4_cursor_selected():
	add_molotov.emit()
	
func _on_shop_slot_5_cursor_selected():
	add_poison.emit()
	
func _on_shop_slot_6_cursor_selected():
	add_spice.emit()
	
func _on_shop_slot_7_cursor_selected():
	add_mitts.emit()
	
func _on_shop_slot_8_cursor_selected():
	add_apron.emit()
	
func _on_shop_pressed():
	open()

#Mouse Button Input
func _on_shop_slot_button_pressed():
	add_cupcake.emit()

func _on_shop_slot_2_button_pressed():
	add_knife.emit()

func _on_shop_slot_3_button_pressed():
	add_toaster.emit()

func _on_shop_slot_4_button_pressed():
	add_molotov.emit()

func _on_shop_slot_5_button_pressed():
	add_poison.emit()

func _on_shop_slot_6_button_pressed():
	add_spice.emit()

func _on_shop_slot_7_button_pressed():
	add_mitts.emit()

func _on_shop_slot_8_button_pressed():
	add_apron.emit()


