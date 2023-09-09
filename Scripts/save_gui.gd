extends Control

signal opened
signal closed

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
	$Timer.start()
	opened.emit()

func close():
	visible = false
	is_open = false 
	cursor.cursor_disabled()
	closed.emit()

func _on_timer_timeout():
	cursor.cursor_enabled()
