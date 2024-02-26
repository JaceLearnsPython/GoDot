extends Button

# card suits and values
var suits = ["hearts", "diamonds", "clubs", "spades"]
var values = ["02", "03", "04", "05", "06", "07", "08", "09", "10", "A"]
var player_deck = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func deal() -> void:
	pass # need to deal cards

func shuffle():
	pass
#
func _physics_process(_delta: float) -> void:
	pass # nothing yet

func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/SinglePlayer.tscn")
