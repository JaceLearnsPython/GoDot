extends "SinglePlayer.gd"


# holds the CardUI nodes
var ai_hand = []
var ai_deck = []
var played_deck = []
var active_decks = []

var played_count = 0
var ai_blitz_played = 0

var deck_index = 0

# timer delay
var timer = 0.0
var rand = RandomNumberGenerator.new()
var delay = rand.randf_range(90,100)

func _ready():
	
	ai_deck = make_deckAI() # returns a shuffled deck of cards 1-10 and all 4 suits
	starting_dealAI()
	draw()

	for i in range(16):
		var node
		var path = "../Container/deck_collision" + str(i+1) + "/TextureRect"
		node = get_node(path)
		active_decks.append(node)
	
	
	
# called every frame to process AI logic
func _process(delta):
	if timer < delay:
		timer+=1
		return

	draw()
	timer = 0
	
#=====================================================================
# Helpers and other functions

# make a deck, returns a shuffled deck.
func make_deckAI():
	var deck = []
	for suit in suits:
		for num in values:
			deck.append(str("_" + suit + "_" + num))
	deck.shuffle()
	return deck

# Deal 4 cards to the active cards
func starting_dealAI():
	for i in range(4): # loop through the 4 nodes
		
		# get the path of the node and load it
		var path = "CardUI" + str(i+1) + "/TextureRect"
		var node = get_node(path)
		
		# get the card we want to load from our deck, making sure to keep a list of
		# cards we have played / removed from our decck
		var starting_card_str = ai_deck.pop_back()
		played_deck.append(starting_card_str)
		var card = "res://ass/cards/card" + starting_card_str + ".png"
		
		# load the texture to the node
		node.texture = load(card)

# draw a card and replace the top card of the deck
func draw():
	
	# reset the index if we are passed the bounds of the deck
	if deck_index >= ai_deck.size() -1:
		deck_index = 0
		
	# get the deck card and compare to the empty card
	var node = get_node("DeckCard/TextureRect")
	var path = node.texture.get_path()
	var empty_card = "res://ass/cards/card_back.png"
	
	# if its empty, we just need to replace the texture with a new card
	if path == empty_card:
		var num = ai_deck.pop_at(deck_index)
		var card = "res://ass/cards/card" + num + ".png"
		node.texture = load(card)
		deck_index += 3
		return
	
	# put the old card back and get a new one
	var deck_str = path.split("card") # split it so its [0]=path, [1] = suit [2] = num.png
	var old_card = deck_str[2].split(".")[0] # get "_hearts_08"
	var new_card = ai_deck.pop_at(deck_index) # get the new card
	deck_index += 3
	ai_deck.push_back(old_card) # put the old card back
	
	# change texture to new card
	var card = "res://ass/cards/card" + new_card + ".png"
	node.texture = load(card)
	return	
