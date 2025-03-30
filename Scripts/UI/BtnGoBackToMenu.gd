extends Button

@export var refMenu : PackedScene
@export var scene_path : String

func _on_pressed() -> void:
	var scene = load(scene_path)
	SceneSwitcher.switch_scene(scene)
