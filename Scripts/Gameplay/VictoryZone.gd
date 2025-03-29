extends Area2D
@export var victoryScene = "res://Testscene.tscn"

func _on_body_entered(body: Node2D) -> void:
	if(body is Player):
		instance_object()
	
func instance_object():
	var scene_to_instance = preload("res://Scenes/UI/VictoryScreen.tscn")
	var object = scene_to_instance.instantiate()
	
	get_tree().root.add_child(object)
