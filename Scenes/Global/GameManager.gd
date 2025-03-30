extends Node
	
func PauseGame():
	GetPlayer().Pause()
	
func ResumeGame():
	GetPlayer().Resume()
	
func GetTxtEndLevel() -> String:
	return GetDataRessource().txtEndLevel
	
func GetTxtStartLevel():
	return GetDataRessource().txtStartLevel

func GetDataRessource():
	var dataLevel = load("res://Resources/Data_" + GetCurrentScene()
	 +".tres") as DataLevel
	return dataLevel
	
func GetStartBanner():
	return GetDataRessource().startBanner
	
func GetCurrentScene():
	return SceneSwitcher.current_scene.name

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
