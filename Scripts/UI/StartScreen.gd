extends Control

class_name StartScreen

func _ready() -> void:
	$Label.text = GameManager.GetTxtStartLevel()
	$BG.texture = GameManager.GetStartBanner()
	
func _on_timer_timeout() -> void:
	GameManager.ResumeGame()
	queue_free()
