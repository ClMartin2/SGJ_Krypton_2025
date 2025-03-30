extends Control

func _ready() -> void:
	var TxtExplication = $TxtExplication
	TxtExplication.text = GameManager.GetTxtEndLevel()
