extends Node

var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)
	
func DestroyScene() -> void:
	for child in get_tree().root.get_children():
		if child is Node2D:  
			child.queue_free()
			
func Restart() -> void:
	DestroyUI()
	var scene_path = current_scene.scene_file_path  
	
	get_tree().change_scene_to_file(scene_path) 
	
	await get_tree().process_frame  
	await get_tree().process_frame 

	current_scene = get_tree().root.get_child(get_tree().root.get_child_count() - 1)  

func DestroyUI() -> void:
	for child in get_tree().root.get_children():
		if child is Control or child is CanvasLayer:
			child.queue_free()

func _deferred_switch_scene(packedScene):
	DestroyScene()
	DestroyUI()
	
	current_scene = packedScene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
	if(current_scene is Node2D):
		var startScreen : PackedScene = load("res://Scenes/UI/StartScreen.tscn")
		GameManager.AddUI(startScreen)
		GameManager.PauseGame()
