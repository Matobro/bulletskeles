extends Node2D

var lifetime = 2.0
var lifetime_timer = 0.0
var velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	lifetime_timer += delta
	position += velocity * delta

	if lifetime_timer >= lifetime:
		queue_free()
