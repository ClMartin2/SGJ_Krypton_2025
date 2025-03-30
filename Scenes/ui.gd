extends CanvasLayer


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.superconduct:
		$MarginContainer/Label.text = "Temperature = " + str(Global.temperature) + "°c " + "SUPER"
	else :
		$MarginContainer/Label.text = "Temperature = " + str(Global.temperature) + "°c "
	
	if (Global.superconduct):
		$MarginContainer2/Label.text = "Cooper LOVE !!!"
	elif Global.canSuper:
		$MarginContainer2/Label.text = "Cooper available - SPACE BAR"
	elif (Global.temperature <= Global.minSuperTemp):
		$MarginContainer2/Label.text = "It's chilly find LOVE!"
	else:
		$MarginContainer2/Label.text = ""
