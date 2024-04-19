extends "SinglePlayer.gd"


# holds the CardUI nodes
var ai_hand = []
var ai_deck = []
var active_decks = []
var played_count = 0

var ai_blitz_played = 0
var deck_index = 0
# timer delay
var timer = 0.0
var rand = RandomNumberGenerator.new()
var delay = rand.randf_range(90,160)

func _ready():
	ai_deck = make_deck(ai_deck)
	starting_ai_deal(ai_deck)

	for i in range(16):
		var node
		var path = "../Container/deck_collision" + str(i+1) + "/TextureRect"
		node = get_node(path)
		active_decks.append(node)
	
# called every frame to process AI logic
func _process(delta):
	
	# wait for the delay
	timer += 1
	if timer < delay:
		return
	timer = 0
	
	# get the current hand after drawing
	draw()	
	get_hand()
	
	# play card if possible
	for i in len(ai_hand):
		play_card(ai_hand[i], i)
	
func play_card(card, index):

	for i in range(16):
		# get the collision deck node
		var deck = active_decks[i]
		var card_str = str(card.texture.get_path())
		card_str = card_str.split("_")
				
		# play ace
		if deck.texture == null:
			if card_str[2].contains("01.png"):
				deck.texture = card.texture
				update_hand(card, deck, index)
				ai_played = true
				# keep track of points
				if index == 3:
					ai_blitz_played +=1
				else:
					played_count+=1
				return
				
		
		# else check for other options
		if deck.texture != null:
			card_str = str(card.texture.get_path())
			card_str = card_str.split("_") # split it so its [0]=path, [1] = suit [2] = num.png
			
			# check if we can play it 
			var num = int(card_str[2].split(".")[0])
			
			var deck_str = str(deck.texture.get_path())
			deck_str = deck_str.split("_")	
			# check if we can play it 
			var deck_num = int(deck_str[2].split(".")[0])
			
			if num == (deck_num+1) and deck_str[1] == card_str[1]:
				deck.texture = card.texture
				update_hand(card, deck, index)
				ai_played = true
				
				if index == 3:
					ai_blitz_played +=1
				else:
					played_count+=1
				return

func update_hand(card, deck, index):
	var popped_card = ai_deck.pop_back()

	var path = "res://ass/cards/card" + popped_card + ".png"
	ai_hand[index].texture = load(path)
	
	# just make sure we removed the card
	var str_card = card.texture.get_path()
	str_card = str_card.split("/")[4].split("card")[1].split(".")[0] # get _suit_num
	
	# MAKE SURE TO REMOVE THE CARD
	remove_card(str(card.texture.get_path()))




#func validate_deck():
	#for card in ai_deck:
		#if ai_played_cards.has(card):
			#var index = player_deck.find(card)
			#if index >= 0:
				#player_deck.remove_at(index)


# get the cardUI nodes
func get_hand():
	var card1 = get_node("CardUI1/TextureRect")
	var card2 = get_node("CardUI2/TextureRect")
	var card3 = get_node("CardUI3/TextureRect")
	var card4 = get_node("CardUI4/TextureRect")
	var deckCard = get_node("DeckCard/TextureRect")
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
	
	if deck_index >= ai_deck.size() - 1:
		deck_index = 0
	
	var card = "res://ass/cards/card" + ai_deck[deck_index] + ".png"
	card = load(card)
	deck_index+=3 # move 3 at a time like in dutch blitz rules
	
	
	var path = "DeckCard/TextureRect"
	var node = get_node(path)
	node.texture = card
	
