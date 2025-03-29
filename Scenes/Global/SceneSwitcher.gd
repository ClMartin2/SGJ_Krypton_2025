extends Node

var current_scene = null
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)
	
func _deferred_switch_scene(packedScene):
	current_scene.free()
	current_scene = packedScene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
