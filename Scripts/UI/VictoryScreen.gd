extends Control

func _ready() -> void:
		var TxtExplication = $Panel/TxtExplication
		TxtExplication.text = GameManager.GetTxtEndLevel()
