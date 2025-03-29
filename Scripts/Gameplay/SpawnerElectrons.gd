@tool
extends Node2D

@export var radius = 10
@export var numberToSpawn = 1
@export var electron : PackedScene
@export var RandomRangeXVelocity := Vector2(-300,300)
@export var RandomRangeYVelocity := Vector2(-100,100)

func drawCircleSpawn() -> void:
	var center = Vector2.ZERO
	var color = Color(1,0,0)
	
	draw_circle(center,radius,color)

func _draw():
	if Engine.is_editor_hint():
		drawCircleSpawn()

func _ready() -> void:
	Spawn()

func Spawn():
	var angle = randf_range(0, 2 * PI)
	var r = randf_range(0, radius)
   
	var x = r * cos(angle)
	var y = r * sin(angle)
	
	var randomPosition = Vector2(x, y)
	
	for i in range(numberToSpawn):
		var object = electron.instantiate()
		object.position = randomPosition
				
		var electron = object as Electron
		var XVelocity = randf_range(RandomRangeXVelocity.x,RandomRangeXVelocity.y)
		var YVelocity = randf_range(RandomRangeYVelocity.x,RandomRangeYVelocity.y)
		var RandomVelocity = Vector2(XVelocity,YVelocity)
		electron.startVelocity = RandomVelocity
		
		add_child(object)
