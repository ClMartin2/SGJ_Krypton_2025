extends Area2D
@export var victoryScene : PackedScene

func _on_body_entered(body: Node2D) -> void:
	if(body is Player):
		instance_object()
	
func instance_object():
	var object = victoryScene.instantiate()
	get_tree().root.add_child(object)
