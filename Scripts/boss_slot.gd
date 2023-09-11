extends Panel

@onready var backgroundSprite: Sprite2D = $Background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item

func update(item: Boss_Options):
	if !item:
		#backgroundSprite.frame = 0
		itemSprite.visible = false
	else:
		#backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = item.texture
		
signal cursor_selected()
signal button_pressed

func cursor_select() -> void:
	print(name)
	emit_signal("cursor_selected")
	
	
func _on_button_pressed():
	print(name)
	emit_signal("button_pressed")

func resize_slot():
	$CenterContainer/Panel/Item.scale.x = 0.78
	$CenterContainer/Panel/Item.scale.y = 0.78

func disable_button():
	$CenterContainer/Panel/Button.disabled = true

func enable_button():
	$CenterContainer/Panel/Button.disabled = false
