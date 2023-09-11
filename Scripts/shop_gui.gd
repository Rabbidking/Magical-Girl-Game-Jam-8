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

var cupcake_price = 10
var knife_price = 25
var toaster_price = 30
var molotov_price = 15
var poison_price = 15
var spice_price = 25
var mitts_price = 25
var apron_price = 40
var inv_full = false

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
	$NinePatchRect/Money.text = "Money: $%d" % State.money
	$NinePatchRect/Cupcake_Price.text = ("$%d" % cupcake_price)
	$NinePatchRect/Poison_Price.text = ("$%d" % poison_price)
	$NinePatchRect/Knife_Price.text = ("$%d" % knife_price)
	$NinePatchRect/Spice_Price.text = ("$%d" % spice_price)
	$NinePatchRect/Toaster_Price.text = ("$%d" % toaster_price)
	$NinePatchRect/Mitts_Price.text = ("$%d" % mitts_price)
	$NinePatchRect/Molotov_Price.text = ("$%d" % molotov_price)
	$NinePatchRect/Apron_Price.text = ("$%d" % apron_price)
	update()

func update():
	for i in range(min(shop.shop_items.size(), slots.size())):
		slots[i].update(shop.shop_items[i])
	
func update_money():
	$NinePatchRect/Money.text = "Money: $%d" % State.money
	
func open():
	visible = true
	is_open = true
	update_money()
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
	
func buy_cupcake():
	if State.money >= cupcake_price and inv_full == false:
		State.money -= cupcake_price
		update_money()
		add_cupcake.emit()
func buy_knife():
	if State.money >= knife_price and inv_full == false:
		State.money -= knife_price
		update_money()
		add_knife.emit()
func buy_toaster():
	if State.money >= toaster_price and inv_full == false:
		State.money -= toaster_price
		update_money()
		add_toaster.emit()
func buy_molotov():
	if State.money >= molotov_price and inv_full == false:
		State.money -= molotov_price
		update_money()
		add_molotov.emit()
func buy_poison():
	if State.money >= poison_price and inv_full == false:
		State.money -= poison_price
		update_money()
		add_poison.emit()
func buy_spice():
	if State.money >= spice_price and inv_full == false:
		State.money -= spice_price
		update_money()
		add_spice.emit()
func buy_mitts():
	if State.money >= mitts_price and inv_full == false:
		State.money -= mitts_price
		update_money()
		add_mitts.emit()
func buy_apron():
	if State.money >= apron_price and inv_full == false:
		State.money -= apron_price
		update_money()
		add_apron.emit()
	
func _on_shop_slot_cursor_selected():
	buy_cupcake()
func _on_shop_slot_2_cursor_selected():
	buy_knife()
func _on_shop_slot_3_cursor_selected():
	buy_toaster()
func _on_shop_slot_4_cursor_selected():
	buy_molotov()
func _on_shop_slot_5_cursor_selected():
	buy_poison()
func _on_shop_slot_6_cursor_selected():
	buy_spice()
func _on_shop_slot_7_cursor_selected():
	buy_mitts()
func _on_shop_slot_8_cursor_selected():
	buy_apron()
func _on_shop_pressed():
	open()

#Mouse Button Input
func _on_shop_slot_button_pressed():
	buy_cupcake()
func _on_shop_slot_2_button_pressed():
	buy_knife()
func _on_shop_slot_3_button_pressed():
	buy_toaster()
func _on_shop_slot_4_button_pressed():
	buy_molotov()
func _on_shop_slot_5_button_pressed():
	buy_poison()
func _on_shop_slot_6_button_pressed():
	buy_spice()
func _on_shop_slot_7_button_pressed():
	buy_mitts()
func _on_shop_slot_8_button_pressed():
	buy_apron()

func _on_boss_gui_open_shop():
	open()

func _on_inventory_gui_is_full():
	inv_full = true
func _on_inventory_gui_not_full():
	inv_full = false


func _on_inventory_gui_closed():
	pass # Replace with function body.


func _on_inventory_gui_opened():
	pass # Replace with function body.
