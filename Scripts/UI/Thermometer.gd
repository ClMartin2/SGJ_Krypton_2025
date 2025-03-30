extends TextureProgressBar

var maxTemperature := -100.0
var minTemperature := -210.0
@export var colorMaxTemperature := Color(1, 0, 0)
@export var colorMinTemperature := Color(0, 0, 1)

func _process(delta: float) -> void:
	var pourcentageValue = 1 - ((Global.temperature - maxTemperature) / (minTemperature - maxTemperature))

	# Assurer que la valeur reste entre 0 et 1
	pourcentageValue = clamp(pourcentageValue, 0.25, 1.0)

	# Appliquer la valeur à la barre de progression
	value = pourcentageValue * 100

	# Interpolation de la couleur
	tint_progress = colorMinTemperature.lerp(colorMaxTemperature, pourcentageValue)
