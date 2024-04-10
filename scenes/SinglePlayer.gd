extends Node2D

# FORMAT for calling assets will be "res://ass/cards/card{CARD}" + ".png", card = "_clubs_03" etc

# card suits and values
var suits = ["hearts", "diamonds", "clubs", "spades"]
var values = ["02", "03", "04", "05", "06", "07", "08", "09", "10", "A"]
var player_deck = []
var num_of_played = 0
var blitzPlayed = 0

var card1
var card2
var card3
var card4
var deckCard
var hand = []

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
	
# Game Logic and called every frame
func _process(delta):
	var offset: Vector2
	offset = Vector2(0,0)
	
	# Handle dragging
	for i  in len(hand):
		if hand[i].selected:
			hand[i].set_global_position(get_local_mouse_position() - Vector2(50,50))
			hand[i].z_index = 2 # set above other cards.
		
		# putting the card back is handled by card_ui.gd
# <------------------------------------------------------------------------------>
# HELPERS AND BUTTONS BELOW

# make the deck, shuffle it, return it.
func make_deck(deck):
	for suit in suits:
		for num in values:
			deck.append(str("_" + suit + "_" + num))
	deck.shuffle()
	return deck

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
		var node = get_node(path)
		var card = "res://ass/cards/card" + starting_cards[i] + ".png"
		node.texture = load(card)

# DRAW BUTTON
func _on_draw_pressed():
	var rand = random.randi_range(0, player_deck.size() - 1)
	
	var card = "res://ass/cards/card" + player_deck[rand] + ".png"
	card = load(card)
	$Player1/DeckCard/TextureRect.texture = card


# Add the options to leave
func _on_back_button_pressed():
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
