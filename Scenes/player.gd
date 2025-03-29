extends CharacterBody2D

var vel = Vector2(0.5,0.5)

func _ready() -> void:
	add_to_group("electrons")

func _process(delta: float) -> void:
	var acceleration = Input.get_vector("left","right", "up", "down")
	vel += acceleration * 2

	#position += vel * delta

	var collision = move_and_collide(vel * delta)

	if collision:
		var normal = collision.get_normal()
		vel = vel.bounce(normal)
