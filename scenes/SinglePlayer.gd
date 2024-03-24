extends Node2D

# FORMAT for calling assets will be "res://ass/cards/card{CARD}", card = "_clubs_03" etc

# card suits and values
var suits = ["hearts", "diamonds", "clubs", "spades"]
var values = ["02", "03", "04", "05", "06", "07", "08", "09", "10", "A"]
var player_deck = []

# make a random num generator
var random = RandomNumberGenerator.new()
# make the deck, shuffle it, return it.
func make_deck():
	for suit in suits:
		for num in values:
			player_deck.append(str("_" + suit + "_" + num))
	player_deck.shuffle()
	return player_deck

func _ready():
	# for the 4 starting cards all players get
	var starting_cards = []
	
	# create the deck!
	make_deck()
	
	# get the starting cards
	for i in range(4):
		starting_cards.append(player_deck.pop_front())
	
	# modify the cards texture to the new cards.
	var card = "res://ass/cards/card" + starting_cards[0] + ".png"
	$HBoxContainer/CardUI1/TextureRect.texture = load(card)
		
	card = "res://ass/cards/card" + starting_cards[1] + ".png"
	$HBoxContainer/CardUI2/TextureRect.texture = load(card)
	
	card = "res://ass/cards/card" + starting_cards[2] + ".png"
	$HBoxContainer/CardUI3/TextureRect.texture = load(card)
	
	card = "res://ass/cards/card" + starting_cards[3] + ".png"
	$HBoxContainer/CardUI4/TextureRect.texture = load(card)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
