extends Node2D
@export var looseScreen : PackedScene
@export var rotationSpeed := float(5)

func _process(delta: float) -> void:
	rotation += rotationSpeed * delta
	
func _on_body_entered(body: Node2D) -> void: 
	if(body is Player and !Global.superconduct):
		GameManager.AddUI(looseScreen)
		GameManager.PauseGame()
