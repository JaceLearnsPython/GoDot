extends "SinglePlayer.gd"


# holds the CardUI nodes
var ai_hand = [] # filled with text rect nodes
var ai_deck = [] 
var played_deck = []
var active_decks = []
var played = false

var ai_total_played = 0
var ai_blitz_played = false
var ai_blitz_points = 0

var deck_index = 0

# timer delay
var timer = 0.0
var delay = ChangeToSinglePlayer.time_delay # delay is dictated by the mode the user chooses


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
func _process(_delta):
	
	check_game_end()
	if game_end:
		end_the_game()
	
	# delay the AI
	if timer < delay:
		timer+=1
		return
		
	if played:
		played = false
		
	draw()
	get_hand()
	play_card()
	timer = 0
	
	#print("Length of AI deck: " + str(len(ai_deck)))
	#print("Played Blitz: " + str(ai_blitz_points))
	#print("Played Count: " + str(played_count))
#=====================================================================
# Helpers and other functions

# Update the ai_hand
func get_hand():
	for i in range(4):
		var node_str = "CardUI" + str(i+1) + "/TextureRect"
		ai_hand.insert(i, get_node(node_str))
	var deck_node = "DeckCard/TextureRect"
	ai_hand.insert(4, get_node(deck_node)) # don't forget deck node

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
	# make sure deck is not empty
	if len(ai_deck) == 0:
		return

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

# handles the logic of playing card, including
# checking the hand, playing the card, and removing the card
# from the deck. Most of the game logic relies on this function
func play_card():
	# loop through all the active decks
	for i in range(len(active_decks)):
		# check if we can play the current hand card in the active deck
		for j in range(len(ai_hand)):
			play_card_on_deck(j, ai_hand[j], active_decks[i])
			if played:
				update_hand(j)
				ai_total_played += 1
				# make sure to count every non deck card as a point towards the blitz points.
				if j != 4:
					ai_blitz_points += 1
				return

# curr_ad = the current active deck card
# hand_card is the hand card node
# function to play a card on a deck if possible
func play_card_on_deck(index, hand_card, curr_ad):
	var card_node = hand_card.texture.get_path()
	var card_num = int(card_node.split("_")[2].split(".")[0])
	var card_suit = str(card_node.split("_")[1])
	
	# play an 1 if the active deck is empty
	if curr_ad.texture == null and card_num == 1:
		curr_ad.texture = hand_card.texture
		played = true # set it to played so we exit in play_card
		
		# make sure to count the blitz played
		if index == 3:
			ai_blitz_played = true
		return
	
	# get ad info
	if curr_ad.texture != null:

		var ad_node = curr_ad.texture.get_path()
		var ad_num = int(ad_node.split("_")[2].split(".")[0])
		var ad_suit = str(ad_node.split("_")[1])

		if card_num == (ad_num+1) and ad_suit == card_suit:
			curr_ad.texture = hand_card.texture
			played = true
		
			# make sure to count the blitz played
		if index == 3:
			ai_blitz_played = true
			
		return	
	# check if card num is higher than deck num
	# and check suit matches
	

func update_hand(index):
	
	if ai_deck.is_empty():
		return

	var card = ai_deck.pop_back()
	var tex = load("res://ass/cards/card" + card + ".png")
	ai_hand[index].texture = tex

# called to check if the game is over / if anyone has plaayed more than 10 blitz cards
func check_game_end():	
	if ai_blitz_points >= 10 || blitz_played >= points_needed_to_win:
		game_end = true

# called when the game is over.
func end_the_game():
	# score the points to the 'main' leaderboard in SW
	
	# record the time taken (TBD subtract time paused)
	var unix_end_time = Time.get_unix_time_from_system()
	var time_taken = int((unix_end_time - unix_start_time) - 4) # 4 for game start delay
	ChangeToSinglePlayer.time_taken = time_taken

	# SW requires disctionary for metadata
	var metadata : Dictionary = {"time" : time_taken}
	
	# check who won and act accordingly
	if blitz_played >= points_needed_to_win:
		ChangeToSinglePlayer.player_won = true
	else:
		ChangeToSinglePlayer.player_won = false
	
	# record the score for player.
	ChangeToSinglePlayer.score = num_of_played
	
	# add child to keep it in the tree
	add_child(SilentWolf.Scores.save_score(ChangeToSinglePlayer.player_name, num_of_played, "testing", metadata))
	
	# change to the game_end for displaying score and leaderboards
	get_tree().change_scene_to_file("res://scenes/game_end.tscn")
