extends "SinglePlayer.gd"


# holds the CardUI nodes
var ai_hand = []
var ai_deck = []
var active_decks = []

# timer delay
var timer = 0.0
var rand = RandomNumberGenerator.new()
var delay = rand.randf_range(60,80)

func _ready():
	ai_deck = make_deck(ai_deck)
	starting_ai_deal(ai_deck)

	for i in range(16):
		var node
		var path = "../Container/deck_collision1"
		node = get_node("../Container/deck_collision1")
		print(node)

	
# called every frame to process AI logic
func _process(delta):
	
	# wait for the delay
	timer += 1
	if timer < delay:
		return
	timer = 0
	
	# after the delay, make a move if possible

	# get the current hand after drawing
	draw()	
	get_hand()
	for card in hand:
		play_card(card)
	
	# check if we can play
	
func play_card(card):
	pass


# get the cardUI nodes
func get_hand():
	var card1 = get_node("CardUI1")
	var card2 = get_node("CardUI2")
	var card3 = get_node("CardUI3")
	var card4 = get_node("CardUI4")
	var deckCard = get_node("DeckCard")
	ai_hand = [card1, card2, card3, card4, deckCard]
# chose to use essentailly a duplicate function since the path is different than when
# the singeplayer script is used
func starting_ai_deal(deck):
	
	var starting_cards = []
	
	var path = ""
	
	# get the starting cards
	for i in range(4):
		starting_cards.append(deck.pop_front())
	
	# Set the texture of each card
	for i in range(4):
		path = "CardUI" + str(i+1) + "/TextureRect"
		var node = get_node(path)
		var card = "res://ass/cards/card" + starting_cards[i] + ".png"
		node.texture = load(card)

func draw():
	var rand = random.randi_range(0, ai_deck.size() - 1)
	
	var card = "res://ass/cards/card" + ai_deck[rand] + ".png"
	card = load(card)
	
	var path = "DeckCard/TextureRect"
	var node = get_node(path)
	node.texture = card
	
