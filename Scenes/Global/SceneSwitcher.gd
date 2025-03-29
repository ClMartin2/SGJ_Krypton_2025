extends Node

var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)
	
func _deferred_switch_scene(packedScene):
	for child in get_tree().root.get_children():
		if child is Node2D or child is Control or child is CanvasLayer:  # Vérifie si c'est un Node2D ou un Control (UI)
			child.queue_free()
	
	current_scene = packedScene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
	if(current_scene is Node2D):
		var startScreen : PackedScene = load("res://Scenes/UI/StartScreen.tscn")
		GameManager.AddUI(startScreen)
		GameManager.PauseGame()
