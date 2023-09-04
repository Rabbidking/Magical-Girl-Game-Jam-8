extends Panel

@onready var backgroundSprite: Sprite2D = $Background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item

func update(item: Shop_Inventory):
	if !item:
		#backgroundSprite.frame = 0
		itemSprite.visible = false
	else:
		#backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = item.texture

signal cursor_selected()

func cursor_select() -> void:
	print(name)
	emit_signal("cursor_selected")
