extends Node

class_name Weapon

var stats: WeaponStats

var cooldown = 0.2
var _cooldown_timer = 0.0

func _process(delta: float) -> void:
	if _cooldown_timer > 0.0:
		_cooldown_timer -= delta

func call_shoot():
	if _cooldown_timer <= 0:
		shoot()
		_cooldown_timer = cooldown
		
#overridden per weapon - i think idk fsajiofsajoifsajhinp
func shoot():
	pass
