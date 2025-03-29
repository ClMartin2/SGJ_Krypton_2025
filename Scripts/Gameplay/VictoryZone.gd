extends Area2D

@export var winScreen : PackedScene

func _on_body_entered(body: Node2D) -> void:
	if(body is Player):
		GameManager.AddUI(winScreen)
		GameManager.PauseGame()
