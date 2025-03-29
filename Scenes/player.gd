extends CharacterBody2D
class_name Player

var vel = Vector2(0.5,0.5)

func _ready() -> void:
	add_to_group("electrons")

#@onready var all_electrons = get_tree().get_nodes_in_group("electrons")

func _process(delta: float) -> void:
	var all_electrons = get_tree().get_nodes_in_group("electrons")
	var acceleration = Input.get_vector("left","right", "up", "down")
	vel += acceleration * 2

	#position += vel * delta
	
	var repulsion_force = Vector2.ZERO

	for other in all_electrons:
		if other == self:
			continue
			
		var diff = global_position - other.global_position
		var distance = diff.length()
		
		if distance < 500.0 and distance > 0.1:
			var strength = 5000.0 / pow(distance, 2)
			repulsion_force += diff.normalized() * strength * 1000
			#print("rep force" + str(repulsion_force))
			
	#print(str(repulsion_force.length()))
	vel += repulsion_force * delta
	
	# 🧱 Limiter la vitesse max ici
	var max_speed = 1200 + (Global.temperature * 5)
	#var max_speed = 300
	if vel.length() > max_speed:
		vel = vel.normalized() * max_speed

	var collision = move_and_collide(vel * delta)

	if collision:
		var normal = collision.get_normal()
		vel = vel.bounce(normal)
