extends CharacterBody2D
class_name Player

var vel = Vector2(0.5,0.5)
var pause = false;
var canSuper = false

#@onready var halo = preload("res://halo.tscn").instantiate()

func _ready() -> void:
	add_to_group("electrons")
	#get_tree().get_root().add_child(halo) # ajoute le halo une seule fois
	
	
#@onready var all_electrons = get_tree().get_nodes_in_group("electrons")

func Pause():
	pause = true
	remove_from_group("electrons")
	velocity = Vector2.ZERO
	
func Resume():
	pause = false
	add_to_group("electrons")

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
	
	var target = get_closest_electron()
	
	if (target and Global.temperature <= Global.minSuperTemp):
		#print("CAN SUPER")
		Global.canSuper = true
	else:
		#print("NO SUPER")
		Global.canSuper = false
		
	
	if (Input.is_action_just_pressed("launch_super") and Global.canSuper and !Global.superconduct) :
		Global.superconduct = !Global.superconduct
		#print("pressed - SUPER")
	
	if (Global.superconduct and Global.temperature > Global.minSuperTemp):
		Global.superconduct = false
	
	if Global.superconduct:
		vel += acceleration * 1500 * delta
		rotation += 10 * delta
	else:
		vel += acceleration * 750 * delta
		rotation = 0
	
	# RECHERCHE DE CLOSEST POUR HALO
	
	if (target and Global.canSuper and !Global.superconduct):
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

	vel += repulsion_force * delta
	
	# 🧱 Limiter la vitesse max ici
	var max_speed = 1200 + (Global.temperature * 5)
	var min_speed = max_speed - 200
	#var max_speed = 300
	if vel.length() > max_speed:
		vel = vel.normalized() * max_speed
	if vel.length() < min_speed:
		vel = vel.normalized() * min_speed
		
	
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


func _on_timer_timeout() -> void:
	if (Global.temperature < Global.minSuperTemp + 10):
		Global.temperature += 1
