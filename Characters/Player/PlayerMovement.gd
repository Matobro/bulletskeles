extends CharacterBody2D

class_name PlayerMovement

@export var speed: float = 100.0

var controls_enabled: bool = false
var facing_right: bool = true 

var animations: PlayerAnimations

func initialize_movement():
	animations = $AnimatedSprite2D
	controls_enabled = true

func handle_input() -> Vector2:
	var move_dir = Input.get_vector("left", "right", "up", "down")
	velocity = move_dir * speed

	return move_dir

func handle_orientation(dir):
	if dir.x == 0:
		return  # ignore if going straight up/down

	if abs(dir.x) < 0.4:
		return  # ignore small movements

	if dir.x > 0 and !facing_right:
		animations.flip_h = false
		facing_right = true
	elif dir.x < 0 and facing_right:
		animations.flip_h = true
		facing_right = false
		
func _physics_process(_delta: float) -> void:
	if !controls_enabled: return

	var dir = handle_input()
	if dir:
		move_and_slide()
		handle_orientation(dir)