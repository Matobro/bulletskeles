extends Node2D

var movement: PlayerMovement
var input: PlayerInput

var current_weapon: Weapon

var inventory = [] # weapon scene, weapon stats
var current_index = 0
func _ready():
	setup_player()
	add_test_gun()
	
func add_test_gun():
	inventory.append({
		"scene": preload("res://Weapons/Gun.tscn"),
		"stats": preload("res://WeaponStats/Gun.tres")
	})

	equip_weapon(0)

func setup_player():
	movement = $Player
	movement.initialize_movement()

	input = $Player/PlayerInput
	input.initialize_input(self)

func equip_weapon(index: int):
	if current_weapon:
		current_weapon.queue_free()
	
	current_index = index

	var data = inventory[index]

	current_weapon = data["scene"].instantiate()
	current_weapon.stats = data["stats"]

	$Player/WeaponSlot.add_child(current_weapon)
	current_weapon.position = $Player/WeaponPoint.position
