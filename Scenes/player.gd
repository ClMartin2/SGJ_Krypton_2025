extends CharacterBody2D
class_name Player

var vel = Vector2(0.5,0.5)
var pause = false;

#@onready var halo = preload("res://halo.tscn").instantiate()

func _ready() -> void:
	add_to_group("electrons")
	#get_tree().get_root().add_child(halo) # ajoute le halo une seule fois
	#print("HALO AJOUTE?")
	
	
#@onready var all_electrons = get_tree().get_nodes_in_group("electrons")

func Pause():
	pause = true
	remove_from_group("electrons")
	velocity = Vector2.ZERO

func get_closest_electron() -> RigidBody2D:
	var closest = null
	var min_dist = INF
	for e in get_tree().get_nodes_in_group("electrons"):
		if e == self:
			continue
		var dist = global_position.distance_to(e.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = e
			
	if min_dist > 100:
		return null
	return closest

func _process(delta: float) -> void:
	if(pause):
		return
		
	var all_electrons = get_tree().get_nodes_in_group("electrons")
	var acceleration = Input.get_vector("left","right", "up", "down")
	
	if (Input.is_action_just_pressed("launch_super")) :
		Global.superconduct = !Global.superconduct
		print("pressed - SUPER")
	
	if Global.superconduct:
		vel += acceleration * 20
		rotation += 5 * delta
	else:
		vel += acceleration * 2
		rotation = 0
	
	# RECHERCHE DE CLOSEST POUR HALO
	var target = get_closest_electron()
	if target:
		$"../halo".global_position = target.global_position
		$"../halo".visible = true
		#halo.global_position = target.global_position
		#halo.visible = true
		#print("HALO VISIBLE")
	else:
		$"../halo".visible = false
		#halo.visible = false
		
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
		
	
	if Global.superconduct:
		vel = vel.normalized() * 1000
		$Sprite2D_normal.visible = false
		$Sprite2D2_super.visible = true
	else: 
		$Sprite2D_normal.visible = true
		$Sprite2D2_super.visible = false

	var collision = move_and_collide(vel * delta)

	if collision:
		var normal = collision.get_normal()
		vel = vel.bounce(normal)
