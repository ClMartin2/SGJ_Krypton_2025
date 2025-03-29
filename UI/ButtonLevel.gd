extends Button

@export var levelToLoad = "res://Scenes/Levels/Level1.tscn"

#func _on_resized() -> void:
	#adjustTextSize()

func adjustTextSize():
	var label = get_node("Label")
	if label:
		var font = FontFile.new()
		font.load("res://Fonts/GameBubble.ttf")  
		
		var settings = LabelSettings.new()
		settings.font = font
		settings.font_size = int(size.y / 3) 

		label.label_settings = settings  


func _on_pressed() -> void:
	get_tree().change_scene_to_file(levelToLoad);
