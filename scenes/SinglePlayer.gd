extends Node2D

# FORMAT for calling assets will be "res://ass/cards/card{CARD}" + ".png", card = "_clubs_03" etc

# card suits and values
var suits = ["hearts", "diamonds", "clubs", "spades"]
var values = ["02", "03", "04", "05", "06", "07", "08", "09", "10", "A"]
var player_deck = []
var num_of_played = 0

var blitz_pile = 10 # All players start with 10 cards in the blitz pile

# make a random num generator
var random = RandomNumberGenerator.new()

# make the deck, shuffle it, return it.
func make_deck(deck):
	for suit in suits:
		for num in values:
			deck.append(str("_" + suit + "_" + num))
	deck.shuffle()
	return deck

func _ready():
	
	# holds AI decks
	var ai_deck1 = []
	var ai_deck2 = []
	var ai_deck3 = []
	
	# AI decks
	make_deck(ai_deck1)
	make_deck(ai_deck2)
	make_deck(ai_deck3)
	
	# create the deck for main player
	make_deck(player_deck)
	
	# get the starting cards
	starting_deal(player_deck, "Player1")
	
	# deal for the AI
	starting_deal(ai_deck1, "AI_Player2")
	starting_deal(ai_deck2, "AI_Player3")
	starting_deal(ai_deck3, "AI_Player4")

# Deal the starting cards!
func starting_deal(deck, player):
	
	var starting_cards = []
	var path = ""
	
	# get the starting cards
	for i in range(4):
		starting_cards.append(deck.pop_front())
	
	# Set the texture of each card
	for i in range(4):
		path = player + "/CardUI" + str(i+1) + "/TextureRect"
		print(path)
		var node = get_node(path)
		var card = "res://ass/cards/card" + starting_cards[i] + ".png"
		node.texture = load(card)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
# most likely will use this for game logic if it works as I expect.
func _process(delta):
	pass

# DRAW BUTTON
func _on_draw_pressed():
	var next_card
	var rand = random.randi_range(0, player_deck.size() - 1)
	
	var card = "res://ass/cards/card" + player_deck[rand] + ".png"
	card = load(card)
	$Deck.texture_normal = card
	
	# TBD will need to be able to drag card and drop it to play.
	# If they dont want to play, they should be able to draw again.
	# It would be best to have a "D" for draw key and then draw a new card when 
	# D is pressed.
	
	# Also change Deck to just be a texture and not a button texture.

# Add the options to leave
func _on_back_button_pressed():
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

