extends RigidBody2D

class_name Electron

var vel = Vector2(200, 200)
var startVelocity = Vector2(300, -200)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("electrons")
	linear_velocity = startVelocity

@onready var all_electrons = get_tree().get_nodes_in_group("electrons")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#pass
	##position += vel * delta
	#
	#move_and_collide(vel, delta)
	##var collision_info = move_and_collide(vel, delta)
	##if collision_info:
		##vel = vel.bounce(collision_info.get_normal())
		
	##SOLUTION 1 - OK BOUNCE
	#var collision = move_and_collide(vel * delta)
#
	#if collision:
		#var normal = collision.get_normal()
		#vel = vel.bounce(normal)
		#
	
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
			
	vel += repulsion_force * delta
	
		# 🧱 Limiter la vitesse max ici
	var max_speed = 300.0
	if vel.length() > max_speed:
		vel = vel.normalized() * max_speed
	var collision = move_and_collide(vel * delta)
	
	if collision:
		vel = vel.bounce(collision.get_normal())
