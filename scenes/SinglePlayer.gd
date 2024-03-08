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
	deal(1) # give the number of cards to deal
	pass # Replace with function body.
	
func deal(num) -> void:
	pass # need to deal cards

func shuffle():
	pass
#
func _physics_process(_delta: float) -> void:
	pass # nothing yet

func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/SinglePlayer.tscn")
