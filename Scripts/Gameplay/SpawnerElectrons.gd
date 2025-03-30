@tool
extends Node2D

@export var radius = 10
@export var numberToSpawn = 1
@export var electron : PackedScene
@export var randomRangeXVelocity := Vector2(-300,300)
@export var randomRangeYVelocity := Vector2(-100,100)
@export var color := Color(0, 242, 69)

func drawCircleSpawn() -> void:
	draw_circle(Vector2.ZERO,radius,color)

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
		var electronObject = electron.instantiate()
		electronObject.position = randomPosition
				
		var electronScript = electronObject as Electron
		var XVelocity = randf_range(randomRangeXVelocity.x,randomRangeXVelocity.y)
		var YVelocity = randf_range(randomRangeYVelocity.x,randomRangeYVelocity.y)
		var RandomVelocity = Vector2(XVelocity,YVelocity)
		
		if(electronScript != null):
			electronScript.startVelocity = RandomVelocity
			add_child(electronObject)
