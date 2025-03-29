extends Node2D
@export var looseScreen : PackedScene

func _on_body_entered(body: Node2D) -> void: 
	if(body is Player):
		GameManager.AddUI(looseScreen)
		GameManager.PauseGame()
