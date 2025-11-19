extends Node2D

class_name Player

var movement: PlayerMovement
var input: PlayerInput
var weapon_ui: WeaponUI

var current_weapon: Weapon

var inventory = [] # weapon scene, weapon stats
var current_index = 0

func _ready():
	setup_player()
	add_test_gun()
	update_weapon_ui()
	
func add_test_gun():
	inventory.append({
		"scene": preload("res://Weapons/Gun.tscn"),
		"stats": preload("res://WeaponStats/Gun.tres")
	})

	inventory.append({
		"scene": preload("res://Weapons/Smg.tscn"),
		"stats": preload("res://WeaponStats/Smg.tres")
	})

	inventory.append({
		"scene": preload("res://Weapons/Shotgun.tscn"),
		"stats": preload("res://WeaponStats/Shotgun.tres")
	})

	equip_weapon(0)

func setup_player():
	movement = $Player
	movement.initialize_movement()

	input = $Player/PlayerInput
	input.initialize_input(self)

	weapon_ui = $CanvasLayer/UI/WeaponPanel

func change_weapon(dir):
	if inventory.size() <= 1: return

	var temp_index = (current_index + dir) % inventory.size()

	equip_weapon(temp_index)

func equip_weapon(index: int):
	if current_weapon:
		current_weapon.queue_free()
	
	current_index = index

	var data = inventory[index]

	current_weapon = data["scene"].instantiate()
	current_weapon.stats = data["stats"]
	current_weapon.setup_weapon()

	$Player/WeaponSlot.add_child(current_weapon)
	current_weapon.position = $Player/WeaponPoint.position

	current_weapon.player = self
	update_weapon_ui()

func update_weapon_ui():
	weapon_ui.update_weapon(current_weapon)
