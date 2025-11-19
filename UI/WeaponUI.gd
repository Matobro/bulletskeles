extends Node

class_name WeaponUI

var weapon_stats: WeaponStats
var weapon: Weapon

var weapon_text
var ammo_text
var magazine_text

func _ready() -> void:
    weapon_text = $WeaponName
    ammo_text = $AmmoAmount
    magazine_text = $MagazineAmount

func update_weapon(wep):
    weapon = wep
    weapon_stats = wep.stats

    update_name()
    update_ammo()
    update_magazine()

func update_name():
    weapon_text.text = weapon_stats.weapon_name

func update_ammo():
    ammo_text.text = str(weapon_stats.ammo)

func update_magazine():
    magazine_text.text = str(weapon_stats.current_magazine)


