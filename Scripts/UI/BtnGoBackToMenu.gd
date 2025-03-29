extends Button

@export var refMenu = "res://Scenes/UI/StartMenu.tscn"

func _on_pressed() -> void:
	SceneSwitcher.switch_scene(refMenu)
