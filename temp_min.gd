extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_area_entered(_area: Area2D) -> void:
	#pass # Replace with function body.
	print("YOU ENTERED")


func _on_body_entered(_body: Node2D) -> void:
	#pass # Replace with function body.
	print("body ENTERED")
	if (Global.temperature > -220):
		Global.temperature -= 10
