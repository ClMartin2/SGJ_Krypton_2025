extends Node

var player : Player

func _ready() -> void:
	player = GetPlayer()
	
func PauseGame():
	player.Pause();
	

func GetPlayer():
	var player = get_tree().root.find_child("Player",true,false)
	if player:
		return player as Player
	else:
		print("Player not found!")
		return null

func AddUI(sceneToAdd : PackedScene): 
	var sceneToInstantiate = sceneToAdd.instantiate()
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 10  
	canvas_layer.add_child(sceneToInstantiate)

	get_tree().root.add_child(canvas_layer)
