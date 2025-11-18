extends Node2D

class_name PlayerInput

var player

func initialize_input(player_ref):
	player = player_ref

func _input(event):
	if !player.current_weapon: return

	var aim_vector = Vector2(
		Input.get_axis("look_left", "look_right"),
		Input.get_axis("look_up", "look_down")
	)

	var angle = aim_vector.angle()
	if aim_vector.length() > 0.2:
		player.current_weapon.rotation = angle
		if abs(rad_to_deg(angle)) > 90:
			player.current_weapon.scale.y = -1
		else:
			player.current_weapon.scale.y = 1

	if event.is_action_pressed("shoot"):
		player.current_weapon.call_shoot()
