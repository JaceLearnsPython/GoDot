extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var cardSize = size
	$Area2D/CardCollision.scale = cardSize
