extends Node2D

class_name Weapon

var barrel
var stats: WeaponStats
var player: Player

var cooldown = 0.2
var _cooldown_timer = 0.0
var _reload_timer = 0.0
var _reloading: bool = false

func setup_weapon():
	barrel = $Barrel
	cooldown = stats.fire_rate

func _process(delta: float) -> void:
	if _cooldown_timer > 0.0:
		_cooldown_timer -= delta

	if _reload_timer > 0.0:
		_reload_timer -= delta
		if _reload_timer <= 0.0:
			_reloading = false
			_reload()

## Call reload (start timer)
func _call_reload():
	if _reloading: return

	_reloading = true
	_reload_timer = stats.reload_time

## Execute reload
func _reload():
	var reload_amount: int

	if stats.ammo < stats.magazine_size:
		reload_amount = stats.ammo
	else:
		reload_amount = stats.magazine_size
	
	stats.current_magazine += reload_amount
	stats.ammo -= reload_amount
	player.update_weapon_ui()

## Check if ammo in gun
func has_ammo() -> bool:
	if stats.ammo > 0:
		return true
	return false

## Check if ammo in mag
func has_bullet_in_magazine() -> bool:
	if stats.current_magazine > 0:
		return true
	return false

## Call shoot
func call_shoot():
	if _reloading or _cooldown_timer > 0: return

	if has_bullet_in_magazine():
		shoot()
		_cooldown_timer = cooldown
		stats.current_magazine -= stats.bullet_usage
		clampi(stats.bullet_usage, 0, stats.magazine_size)
		player.update_weapon_ui()

	else:
		if has_ammo():
			_call_reload()
		
#overridden per weapon - i think idk fsajiofsajoifsajhinp
## Execute shoot
func shoot():
	for i in range(stats.projectiles):
		var bullet = stats.projectile_scene.instantiate()

		var spread = deg_to_rad(stats.spread)
		var rng_offset = randf_range(-spread, spread)
		bullet.global_position = barrel.global_position
		
		get_tree().current_scene.add_child(bullet)
		var direction = Vector2.RIGHT.rotated(rotation + rng_offset)
		bullet.velocity = direction * stats.bullet_speed
