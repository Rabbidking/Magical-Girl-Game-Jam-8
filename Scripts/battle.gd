extends Control

signal textbox_closed

@export var enemy: Resource = null

@onready var inventory = $ItemsPanel/Inventory_GUI
@onready var cursor = $ActionsPanel/Cursor

var cur_player_health = 0
var cur_enemy_health = 0
var player_is_poisoned = false
var player_poisoned_counter = 0
var player_immunity = false
var player_immunity_counter = 0
var is_defending = false
var wearing_apron = false
var apron_counter = 0
var paralysis_count = 0
var burn_count = 0
var poison_count = 0
var blind_count = 0
var buffed = false
var enemy_dead = false

func _ready():
	randomize()
	set_health($PlayerPanel/PlayerData/ProgressBar, State.cur_health, State.max_health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.cur_health, State.max_health)
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	#initalize healths
	cur_player_health = State.cur_health
	cur_enemy_health = enemy.health
	
	enemy.shock_resist = 20
	enemy.blind_resist = 15
	enemy.accuracy = 100
	
	$Text.hide()
	$ActionsPanel.hide()
	
	display_text("A wild %s appears!" % enemy.name.to_upper())
	await textbox_closed
	$ActionsPanel.show()
	$CursorBuffer.start()
	
func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = " HP: %d/%d" % [health, max_health]
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Text.visible or Input.is_action_just_pressed("Select"):
		$Text.hide()
		emit_signal("textbox_closed")
		
	
func display_text(text):
	$ActionsPanel.hide()
	$Text.show()
	$Text/Label.text = text
	
func enemy_turn():
	#display some text
	if enemy.is_burning == true and enemy_dead == false:
		$MagicalGirl/player_molotov.play()
		burn_count -= 1
		cur_enemy_health = max(0, cur_enemy_health - 15)
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
		display_text("%s takes burn damage!" % enemy.name)
		await textbox_closed
		if cur_enemy_health <= 0:
			enemy_die()
			enemy_dead = true
		if burn_count <= 0:
			enemy.is_burning = false
			display_text("%s is no longer burning!" % enemy.name)
			await textbox_closed
	
	if enemy.is_poisoned == true and enemy_dead == false:
		$MagicalGirl/player_poison.play()
		poison_count -= 1
		cur_enemy_health = max(0, cur_enemy_health - 15)
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
		display_text("%s takes poison damage!" % enemy.name)
		await textbox_closed
		if cur_enemy_health <= 0:
			enemy_die()
			enemy_dead = true

		if poison_count <= 0:
			enemy.is_poisoned = false
			display_text("%s is no longer poisoned!" % enemy.name)
			await textbox_closed
			
	if enemy.is_blinded == true and enemy_dead == false:
		display_text("%s can't see very well!" % enemy.name)
		await textbox_closed
		enemy.accuracy = 25
		blind_count -= 1
		if blind_count <= 0:
			display_text("%s is no longer blinded!" % enemy.name)
			await textbox_closed
			enemy.accuracy = 100
			
	if enemy.is_paralyzed == false and enemy_dead == false:
		var enemy_attack = randi() % 108
		print(enemy_attack)
		if randi() % 99 < enemy.accuracy or enemy_attack == 4:
			if enemy.name == "Lamia":
				if enemy.magic < 25:
					enemy_attack = 83
					
#			match enemy_attack:
#				0 and 1 and 2:
					#Light Damage Attacks
			if enemy_attack in range(0, 25):
				if enemy.name == "Cockatrice":
					display_text("%s Pecks Tia!" % enemy.name)
				elif enemy.name == "Lizardwoman":
					display_text("%s Claws Tia twice!" % enemy.name)
				elif enemy.name == "Harpy":
					display_text("%s strikes Tia with her Talons!" % enemy.name)
				elif enemy.name == "Lamia":
					display_text("%s whips Tia with her Tail!" % enemy.name)
					
				await textbox_closed
				$"EnemyContainer/Attack SFX/Light_Attack".play()
				
				if is_defending:
					#is_defending = false
					
					$AnimationPlayer.play("mini_shake")
					await $AnimationPlayer.animation_finished
					
					apron_counter -= 1
					if apron_counter <= 0:
						wearing_apron = false
						is_defending = false
						State.defense = 1
						$"EnemyContainer/Attack SFX/apron_destroy".play()
						display_text("Tia's Apron is destroyed!")
						await textbox_closed
					else:
						display_text("Tia's Apron is still holding!")
						await textbox_closed
						
					
				
				#player health decreases
				if enemy.name == "Lizardwoman":
					cur_player_health = max(0, cur_player_health - (enemy.damage1 * State.defense))
					set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
				
					$AnimationPlayer.play("shake")
					await $AnimationPlayer.animation_finished
			
					display_text("%s dealt %d damage!" % [enemy.name.to_upper(), (enemy.damage1 * State.defense)])
					await textbox_closed
					$"EnemyContainer/Attack SFX/Light_Attack".play()
					
					cur_player_health = max(0, cur_player_health - (enemy.damage1 * State.defense))
					set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
				
					$AnimationPlayer.play("shake")
					await $AnimationPlayer.animation_finished
			
					display_text("%s dealt %d damage!" % [enemy.name.to_upper(), (enemy.damage1 * State.defense)])
					await textbox_closed
				
				else:
					cur_player_health = max(0, cur_player_health - (enemy.damage1 * State.defense))
					set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
				
					$AnimationPlayer.play("shake")
					await $AnimationPlayer.animation_finished
			
					display_text("%s dealt %d damage!" % [enemy.name.to_upper(), (enemy.damage1 * State.defense)])
					await textbox_closed
					
			if enemy_attack in range(26, 61):
				#Medium Damage
				if enemy.name == "Cockatrice":
					display_text("%s gives out a Shrill Crow!" % enemy.name)
					#await textbox_closed
					#$"EnemyContainer/Attack SFX/Medium Attack".play()
				elif enemy.name == "Lizardwoman":
					display_text("%s Bites Tia!" % enemy.name)
					#await textbox_closed
				elif enemy.name == "Harpy":
					display_text("%s drops something on Tia!" % enemy.name)
					#await textbox_closed
				elif enemy.name == "Lamia":
					display_text("%s bites Tia with her Venom Fangs!" % enemy.name)
					#await textbox_closed
					
				await textbox_closed
				$"EnemyContainer/Attack SFX/Medium Attack".play()
				
				if is_defending:
					#is_defending = false
					
					$AnimationPlayer.play("mini_shake")
					await $AnimationPlayer.animation_finished
					
					apron_counter -= 1
					if apron_counter <= 0:
						wearing_apron = false
						is_defending = false
						State.defense = 1
						display_text("Tia's Apron is destroyed!")
						await textbox_closed
					else:
						display_text("Tia's Apron is still holding!")
						await textbox_closed
						
					
				
				#player health decreases
				if enemy.name == "Harpy":
					var drop_attack = randi() % 4
					match drop_attack:
						0:
							display_text("%s dropped a pillow on Tia's head!" % enemy.name)
							await textbox_closed
							
						1:
							display_text("%s dropped pebbles on Tia's head!" % enemy.name)
							await textbox_closed
							$"EnemyContainer/Attack SFX/Drop Trash SFX/Pebbles".play()
							cur_player_health = max(0, cur_player_health - (enemy.damage1 * State.defense))
							set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
				
							$AnimationPlayer.play("shake")
							await $AnimationPlayer.animation_finished
			
							display_text("%s dealt %d damage!" % [enemy.name.to_upper(), (enemy.damage1 * State.defense)])
							await textbox_closed
							
						2:
							display_text("%s dropped a brick on Tia's head!" % enemy.name)
							await textbox_closed
							$"EnemyContainer/Attack SFX/Drop Trash SFX/Brick".play()
							cur_player_health = max(0, cur_player_health - (enemy.damage2 * State.defense))
							set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
				
							$AnimationPlayer.play("shake")
							await $AnimationPlayer.animation_finished
			
							display_text("%s dealt %d damage!" % [enemy.name.to_upper(), (enemy.damage2 * State.defense)])
							await textbox_closed
							
						3:
							display_text("%s dropped a cupcake on Tia's head!" % enemy.name)
							await textbox_closed
							$MagicalGirl/player_heal.play()
							cur_player_health = max(0, cur_player_health + (State.max_health * .5))
							if cur_player_health > State.max_health:
								cur_player_health = State.max_health
							set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
							display_text("You ate a cupcake and it healed %d points!" % int(State.max_health * .5))
							await textbox_closed
							
				elif enemy.name == "Lamia":
					if player_is_poisoned == false:
						player_is_poisoned = true
						player_poisoned_counter = 5
						cur_player_health = max(0, cur_player_health - (enemy.damage2 * State.defense))
						set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
					
						$AnimationPlayer.play("shake")
						await $AnimationPlayer.animation_finished
				
						display_text("%s dealt %d damage!" % [enemy.name.to_upper(), (enemy.damage2 * State.defense)])
						await textbox_closed
						
						display_text("%s injected Tia with Venom!" % enemy.name)
						await textbox_closed
					else:
						cur_player_health = max(0, cur_player_health - (enemy.damage2 * State.defense))
						set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
					
						$AnimationPlayer.play("shake")
						await $AnimationPlayer.animation_finished
				
						display_text("%s dealt %d damage!" % [enemy.name.to_upper(), (enemy.damage2 * State.defense)])
						await textbox_closed
						
						if player_is_poisoned == true:
							display_text("%s already injected Tia with Venom!" % enemy.name)
							await textbox_closed
							
						elif player_immunity == true:
							display_text("Tia is temporarily immune to venom!")
							await textbox_closed
				else:
					cur_player_health = max(0, cur_player_health - (enemy.damage2 * State.defense))
					set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
					
					$AnimationPlayer.play("shake")
					await $AnimationPlayer.animation_finished
				
					display_text("%s dealt %d damage!" % [enemy.name.to_upper(), (enemy.damage2 * State.defense)])
					await textbox_closed
					
			if enemy_attack in range(62, 82):
				#Heavy Attack
				if enemy.name == "Cockatrice":
					display_text("%s gives Tia a Death Stare!" % enemy.name)
					#await textbox_closed
					#$"EnemyContainer/Attack SFX/Heavy Attack".play()
				if enemy.name == "Lizardwoman":
					display_text("%s hits Tia with a Lariat!" % enemy.name)
					#await textbox_closed
				elif enemy.name == "Harpy":
					display_text("%s Dive Strikes Tia!" % enemy.name)
					#await textbox_closed
				elif enemy.name == "Lamia":
					display_text("%s hurls a Fire Ball at Tia!" % enemy.name)
					#await textbox_closed
					enemy.magic -= 25
					
				await textbox_closed
				$"EnemyContainer/Attack SFX/Heavy Attack".play()
				
				if is_defending:
					#is_defending = false
					
					$AnimationPlayer.play("mini_shake")
					await $AnimationPlayer.animation_finished
					
					apron_counter -= 1
					if apron_counter <= 0:
						wearing_apron = false
						is_defending = false
						State.defense = 1
						display_text("Tia's Apron is destroyed!")
						await textbox_closed
					else:
						display_text("Tia's Apron is still holding!")
						await textbox_closed
						
					
				
				#player health decreases
				cur_player_health = max(0, cur_player_health - (enemy.damage3 * State.defense))
				set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
				
				$AnimationPlayer.play("shake")
				await $AnimationPlayer.animation_finished
			
				display_text("%s dealt %d damage!" % [enemy.name.to_upper(), (enemy.damage3 * State.defense)])
				await textbox_closed
					
			if enemy_attack in range(83, 108):
				#Harmless or Special attack
				if enemy.name == "Cockatrice":
					display_text("%s glares at Tia!" % enemy.name)
					$"EnemyContainer/Attack SFX/Special".play()
					await textbox_closed
				if enemy.name == "Lizardwoman":
					if buffed == false:
						display_text("%s does a set of Push-Ups!" % enemy.name)
						await textbox_closed
						$"EnemyContainer/Attack SFX/Special".play()
						display_text("%s attack power increases!" % enemy.name)
						await textbox_closed
						enemy.damage1 += 5
						enemy.damage2 += 5
						enemy.damage3 += 5
						buffed = true
						
					else:
						display_text("%s flexes her muscles!" % enemy.name)
						await textbox_closed
						$"EnemyContainer/Attack SFX/Special".play()
						
				elif enemy.name == "Harpy":
					display_text("%s steals from Tia!" % enemy.name)
					await textbox_closed
					$"EnemyContainer/Attack SFX/Special".play()
					display_text("%s stole $10 from Tia!" % enemy.name)
					await textbox_closed
					State.money -= 10
				elif enemy.name == "Lamia":
					display_text("%s gives Tia a Evil Grin!" % enemy.name)
					await textbox_closed
					$"EnemyContainer/Attack SFX/Special".play()
					
					display_text("%s regains some magic!" % enemy.name)
					await textbox_closed
					enemy.magic += 25
					if enemy.magic > 100:
						enemy.magic = 100
							
		
		else:
			display_text("%s attack missed!" % enemy.name)
			await textbox_closed
			
	if enemy.is_paralyzed == true and enemy_dead == false:
		display_text("%s is paralyzed!" % enemy.name)
		await textbox_closed
		paralysis_count -= 1
		if paralysis_count <= 0:
			enemy.is_paralyzed = false
			display_text("%s is no longer paralyzed!" % enemy.name)
			await textbox_closed
			
	if player_is_poisoned == true and enemy_dead == false:
		player_poisoned_counter -= 1
		cur_player_health = max(0, cur_player_health - 5)
		set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
		$AnimationPlayer.play("shake")
		await $AnimationPlayer.animation_finished
		display_text("Tia is hurt from the venom!")
		await textbox_closed
		
	if player_immunity == true and enemy_dead == false:
		player_immunity_counter -= 1
		if player_immunity_counter <= 0:
			player_immunity = false
			display_text("Tia is no loner immune to venom!")
			await textbox_closed
		
		
	#display_text("%s launches at you fiercely!" % enemy.name)
	#await textbox_closed
	
#	if is_defending:
#		is_defending = false
#
#		$AnimationPlayer.play("mini_shake")
#		await $AnimationPlayer.animation_finished
#
#		display_text("You defended successfully!")
#		await textbox_closed
#
#	else:
#		#player health decreases
#		cur_player_health = max(0, cur_player_health - enemy.damage)
#		set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
#
#		$AnimationPlayer.play("shake")
#		await $AnimationPlayer.animation_finished
#
#		display_text("%s dealt %d damage!" % [enemy.name.to_upper(), enemy.damage])
#		await textbox_closed
		
	if cur_player_health == 0:
		display_text("Tia has been defeated!")
		await textbox_closed

		$AnimationPlayer.play("player_die")
		$MagicalGirl/player_die.play()
		await $AnimationPlayer.animation_finished
		if State.money < 100:
			display_text("Tia received health insurance money!")
			await textbox_closed
			var payout = 100 - State.money 
			State.money += payout
		
		
		await get_tree().create_timer(0.25).timeout
		get_tree().change_scene_to_file("res://Scenes/boss_select.tscn")
		
	else:
		$ActionsPanel.show()
		$CursorBuffer.start()

func _on_run_pressed():
	display_text("Got away safely!")
	await textbox_closed
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://Scenes/boss_select.tscn")


func _on_attack_pressed():
	#display some text
	display_text("Tia strikes with her frying pan!")
	await textbox_closed
	
	#enemy health decreases
	$MagicalGirl/player_attack.play()
	cur_enemy_health = max(0, cur_enemy_health - State.damage)
	#cur_enemy_health = max(0, cur_enemy_health - (State.damage * 1000))
	set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	State.money += 20
	
	$AnimationPlayer.play("enemy_damaged")
	await $AnimationPlayer.animation_finished
	
	display_text("Tia dealt %d damage and gained $20!" % State.damage)
	await textbox_closed
	
	if cur_enemy_health <= 0:
		enemy_die()
		enemy_dead = true
	else:
		enemy_turn()
	


func _on_defend_pressed():
	is_defending = true
	display_text("You prepare defensively!")
	await textbox_closed
	await get_tree().create_timer(0.25).timeout
	enemy_turn()
	


func _on_item_pressed():
	$ItemsPanel/Inventory_GUI.position.x = -1
	$ItemsPanel/Inventory_GUI.position.y = 42
	
func _on_inventory_gui_opened():
	$ItemsPanel.visible = true
	$ActionsPanel/Actions/Attack.disabled = true
	$ActionsPanel/Actions/Item.disabled = true
	$ActionsPanel/Actions/Shop.disabled = true
	$ActionsPanel/Actions/Run.disabled = true
	
func _on_inventory_gui_closed():
	$ItemsPanel.visible = false
	$CursorBuffer.start()
	$ActionsPanel/Actions/Attack.disabled = false
	$ActionsPanel/Actions/Item.disabled = false
	$ActionsPanel/Actions/Shop.disabled = false
	$ActionsPanel/Actions/Run.disabled = false
	
func _on_shop_gui_opened():
	$ItemsPanel.visible = true
	$ActionsPanel/Actions/Attack.disabled = true
	$ActionsPanel/Actions/Item.disabled = true
	$ActionsPanel/Actions/Shop.disabled = true
	$ActionsPanel/Actions/Run.disabled = true
	
func _on_shop_gui_closed():
	$ItemsPanel.visible = false
	$CursorBuffer.start()
	$ActionsPanel/Actions/Attack.disabled = false
	$ActionsPanel/Actions/Item.disabled = false
	$ActionsPanel/Actions/Shop.disabled = false
	$ActionsPanel/Actions/Run.disabled = false
	
	
func _on_inventory_gui_item_used(item):
	$ActionsPanel/Actions/Attack.disabled = false
	$ActionsPanel/Actions/Item.disabled = false
	$ActionsPanel/Actions/Shop.disabled = false
	$ActionsPanel/Actions/Run.disabled = false
	$ItemsPanel.visible = false
	if item == "cupcake":
		if player_is_poisoned == true:
			display_text("Cupcake cured venom poisoning!")
			await textbox_closed
			player_is_poisoned = false
			player_poisoned_counter = 0
			player_immunity = true
			player_immunity_counter = 5
		$MagicalGirl/player_heal.play()
		display_text("Tia ate a cupcake and it healed %d points!" % int(State.max_health * .5))
		cur_player_health = max(0, cur_player_health + (State.max_health * .5))
		if cur_player_health > State.max_health:
			cur_player_health = State.max_health
		set_health($PlayerPanel/PlayerData/ProgressBar, cur_player_health, State.max_health)
		await textbox_closed
		await get_tree().create_timer(0.25).timeout
		enemy_turn()
		
	elif item == "knife":
		display_text("Tia threw a knife!")
		$MagicalGirl/player_knife.play()
		cur_enemy_health = max(0, cur_enemy_health - (State.damage * 3.5))
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
	
		display_text("Tia dealt %d damage!" % (State.damage * 3.5))
		await textbox_closed
	
		if cur_enemy_health <= 0:
			enemy_die()
			enemy_dead = true
		else:
			enemy_turn()
		
	elif item == "toaster":
		display_text("Tia threw a unstable toaster!")
		cur_enemy_health = max(0, cur_enemy_health - (State.damage * 1.6))
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
		$MagicalGirl/player_toaster.play()

		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
	
		display_text("Tia dealt %d damage!" % (State.damage * 1.6))
		await textbox_closed
		
		#resist paralysis to prevent cheesing
		var shock_chance = randi() % 101
		if enemy.is_paralyzed == false and enemy.shock_resist <= shock_chance:
			enemy.is_paralyzed = true
			paralysis_count = 4
			enemy.shock_resist += 25
			display_text("%s is paralzyed!" % enemy.name)
			await textbox_closed
		elif enemy.is_paralyzed == true:
			display_text("%s is already paralzyed!" % enemy.name)
			await textbox_closed
		else:
			display_text("%s resisted paralysis!" % enemy.name)
			await textbox_closed
	
		if cur_enemy_health <= 0:
			enemy_die()
			enemy_dead = true
		else:	
			enemy_turn()
		
	elif item == "molotov":
		display_text("Tia threw a lit molotov!")
		$MagicalGirl/player_molotov.play()
		cur_enemy_health = max(0, cur_enemy_health - (State.damage * 1.7))
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
	
		display_text("Tia dealt %d damage!" % (State.damage * 1.7))
		await textbox_closed
		
		if enemy.is_burning == false:
			enemy.is_burning = true
			burn_count = 4
			display_text("%s is burning!" % enemy.name)
			await textbox_closed
		else:
			display_text("%s is already burning!" % enemy.name)
			await textbox_closed
		
		if cur_enemy_health <= 0:
			enemy_die()
			enemy_dead = true
		else:
			enemy_turn()
		
	elif item == "poison":
		display_text("Tia splashed the enemy with extra strong rat poison!")
		cur_enemy_health = max(0, cur_enemy_health - (State.damage * 1.6))
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
	
		display_text("Tia dealt %d damage!" % (State.damage * 1.6))
		await textbox_closed
		
		if enemy.is_poisoned == false:
			enemy.is_poisoned = true
			poison_count = 7
			display_text("%s has been poisoned!" % enemy.name)
			await textbox_closed
		else:
			display_text("%s has already been poisoned!" % enemy.name)
			await textbox_closed
		
		if cur_enemy_health <= 0:
			enemy_die()
			enemy_dead = true
		else:
			enemy_turn()
		
	elif item == "spice":
		display_text("Tia threw spice powder at %s eyes!" % enemy.name)
		cur_enemy_health = max(0, cur_enemy_health - (State.damage * 0.5))
		set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)

		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished

		display_text("You dealt %d damage!" % (State.damage * 0.5))
		await textbox_closed
		var blind_chance = randi() % 101
		if enemy.is_blinded == false and enemy.blind_resist <= blind_chance:
			enemy.is_blinded = true
			blind_count = 6
			enemy.blind_resist += 25
			display_text("%s has been blinded!" % enemy.name)
			await textbox_closed
		elif enemy.is_blinded == true:
			display_text("%s is already blinded!" % enemy.name)
			await textbox_closed
		else:
			display_text("%s resisted being blinded!" % enemy.name)
			await textbox_closed
			
	
		if cur_enemy_health <= 0:
			enemy_die()
			enemy_dead = true
		else:
			enemy_turn()
		
	elif item == "mitts":
		var barrage = true
		var barrage_attack = randi() % 8
		var cur_attack = 0
		var max_attack = 6
		
		display_text("Tia unleashed a barrage of punches!")
		
		for i in range(0, 2):
			$MagicalGirl/player_mitts.play()
			cur_enemy_health = max(0, cur_enemy_health - (State.damage * 1.3))
			set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
			$AnimationPlayer.play("enemy_damaged")
			await $AnimationPlayer.animation_finished
	
			display_text("Tia dealt %d damage!" % (State.damage * 1.3))
			await textbox_closed
		
		while barrage == true:
			print("barrage mode")
			print(barrage_attack)
			if barrage_attack in range(0, 3):
				$MagicalGirl/player_mitts.play()
				cur_enemy_health = max(0, cur_enemy_health - (State.damage * 1.4))
				set_health($EnemyContainer/ProgressBar, cur_enemy_health, enemy.health)
	
				$AnimationPlayer.play("enemy_damaged")
				await $AnimationPlayer.animation_finished
	
				display_text("Tia dealt %d damage!" % (State.damage * 1.4))
				await textbox_closed
				cur_attack += 1
				barrage_attack = randi() % 8
			
			elif cur_attack >= max_attack:
				barrage = false
				break
			
			else:
				barrage = false
				break
		
		if cur_enemy_health <= 0:
			enemy_die()
			enemy_dead = true
		else:
			enemy_turn()
		
	elif item == "apron":
		if wearing_apron == false:
			wearing_apron = true
			apron_counter = 5
			is_defending = true
			State.defense = 0.75
			$MagicalGirl/player_apron.play()
			display_text("Tia puts on a protective apron!")
			await textbox_closed
		else:
			$MagicalGirl/player_apron.play()
			display_text("Tia tears off her apron to put on the other apron!")
			await textbox_closed
			
		await get_tree().create_timer(0.25).timeout
		enemy_turn()
	

func enemy_die():
	#set flags for boss defeats
	State.money += 50
	State.max_health += 25
	State.cur_health = State.max_health
	set_health($PlayerPanel/PlayerData/ProgressBar, State.cur_health, State.max_health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.cur_health, State.max_health)
	match enemy.name:
		"Cockatrice":
			State.boss_1_def = true
		"Lizardwoman":
			State.boss_2_def = true
		"Harpy":
			State.boss_3_def = true
		"Lamia":
			State.boss_4_def = true
	
	display_text("%s has been defeated and Tia gained $50!" % enemy.name.to_upper())
	await textbox_closed
	
	display_text("Tia gain a boost to her health!")
	await textbox_closed

	$AnimationPlayer.play("enemy_die")
	$EnemyContainer/enemy_die.play()
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(0.25).timeout
	if State.boss_1_def == true and State.boss_2_def == true and State.boss_3_def == true and State.boss_4_def == true:
		get_tree().change_scene_to_file("res://Scenes/end_game.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/boss_select.tscn")

func _on_attack_cursor_selected():
	cursor.cursor_disabled()
	_on_attack_pressed()

func _on_item_cursor_selected():
	cursor.cursor_disabled()
	_on_inventory_gui_opened()
	$ItemsPanel/Inventory_GUI.position.x = -1
	$ItemsPanel/Inventory_GUI.position.y = 42

func _on_shop_cursor_selected():
	cursor.cursor_disabled()
	_on_shop_gui_opened()
	$ItemsPanel/Inventory_GUI.position.x = -1
	$ItemsPanel/Inventory_GUI.position.y = 167

func _on_run_cursor_selected():
	cursor.cursor_disabled()
	_on_run_pressed()

func _on_cursor_buffer_timeout():
	cursor.cursor_enabled()
	cursor.battle_offset()


func _on_shop_pressed():
	print("this here")
	$ItemsPanel/Inventory_GUI.position.x = -1
	$ItemsPanel/Inventory_GUI.position.y = 167
