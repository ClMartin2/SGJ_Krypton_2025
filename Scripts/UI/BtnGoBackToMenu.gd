extends Button

@export var refMenu : PackedScene

func _on_pressed() -> void:
	SceneSwitcher.switch_scene(refMenu)
