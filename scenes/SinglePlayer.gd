extends Button

# card suits and values
var suits = ["hearts", "diamonds", "clubs", "spades"]
var values = ["02", "03", "04", "05", "06", "07", "08", "09", "10", "A"]
var player_deck = []

# get the cardUI scene
const cardUI = preload("res://card_ui/card_ui.tscn")
const singePlayerScene = preload("res://scenes/SinglePlayer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var card = load("res://ass/cards/card_clubs_03.png")
	print(card)
	print($CardTest)
	$CardTest.set_texture(card)
	pass # Replace with function body.

func shuffle():
	pass

#
func _physics_process(_delta: float) -> void:
	pass # nothing yet

func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/SinglePlayer.tscn")
