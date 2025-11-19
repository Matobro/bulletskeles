extends Resource

class_name WeaponStats

@export var damage: int = 1
@export var fire_rate: float = 0.1
@export var projectiles: int = 1
@export var bullet_usage: int = 1
@export var ammo: int = 100
@export var magazine_size: int = 6
@export var current_magazine: int = 6
@export var reload_time: float = 1.0
@export var spread: float = 0.0
@export var bullet_speed: float = 50.0
@export var projectile_scene: PackedScene
@export var shoot_sound: AudioStream