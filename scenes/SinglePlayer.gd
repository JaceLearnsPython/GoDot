extends Node2D

# FORMAT for calling assets will be "res://ass/cards/card{CARD}" + ".png", card = "_clubs_03" etc

# card suits and values
var suits = ["hearts", "diamonds", "clubs", "spades"]
var values = ["02", "03", "04", "05", "06", "07", "08", "09", "10", "01"]
var player_deck = []
var num_of_played = 0
var blitz_played = 0
var ai_played = false # used to keep track if an AI just played to stagger moves so
					  # a deck does not instantly fill.

var card1
var card2
var card3
var card4
var deckCard
var hand = []
var player_deck_index = 0

var played_cards = []


const blitz_pile_size = 10 # All players start with 10 cards in the blitz pile

# make a random num generator
var random = RandomNumberGenerator.new()

# On scene Load
func _ready():
	card1 = get_node("Player1/CardUI1")
	card2 = get_node("Player1/CardUI2")
	card3 = get_node("Player1/CardUI3")
	card4 = get_node("Player1/CardUI4")
	deckCard = get_node("Player1/DeckCard")
	hand = [card1, card2, card3, card4, deckCard]
	
	# create the deck for main player
	make_deck(player_deck)

	# get the starting cards
	starting_deal("Player1")

	
# Game Logic and called every frame
func _process(delta):
	
	# Handle dragging
	for i  in len(hand):
		if hand[i].selected:
			hand[i].set_global_position(get_local_mouse_position() - Vector2(50,50))
			hand[i].z_index = 2 # set above other cards.
			
		if hand[i].played:
			var node_path = str(hand[i].get_path())
			var card_node = get_node(node_path) # grab the card for later
			card_node.played = false
			node_path = node_path + "/TextureRect"
			var node = get_node(node_path)
			remove_card(node.texture.get_path())
			
			# change the node's card
			if len(player_deck) > 0:
				var played_card = player_deck.pop_back()
				played_cards.append(played_card)
				node.texture = load("res://ass/cards/card" + played_card + ".png")
				
				if i == 3:
					blitz_played +=1
				else:
					num_of_played+=1


# <------------------------------------------------------------------------------>
# HELPERS AND BUTTONS BELOW
func remove_card(card):
	card = card.split("card")[2].split(".")[0]
	
	var i = player_deck.find(card)
	if player_deck.find(card) != -1:
		print("deck contains dupe")
		player_deck.remove_at(i)
		print("Removed.\n")

# make the deck, shuffle it, return it.
func make_deck(deck):
	for suit in suits:
		for num in values:
			deck.append(str("_" + suit + "_" + num))
	deck.shuffle()
	return deck

# Deal the starting cards!
func starting_deal(player):
	
	var starting_cards = []
	
	var path = ""
	
	# get the starting cards
	for i in range(4):
		starting_cards.append(player_deck.pop_front())
	
	# Set the texture of each card
	for i in range(4):
		path = player + "/CardUI" + str(i+1) + "/TextureRect"
		var node = get_node(path)
		var card = "res://ass/cards/card" + starting_cards[i] + ".png"
		node.texture = load(card)

# DRAW BUTTON
func _on_draw_pressed():
	# need to change to not be random and treat it like a stack
	if player_deck_index >= player_deck.size() - 1:
		player_deck_index = 0
	
	var card = "res://ass/cards/card" + player_deck[player_deck_index] + ".png"
	card = load(card)
	$Player1/DeckCard/TextureRect.texture = card
	player_deck_index +=3

# Add the options to leave
func _on_back_button_pressed():
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
