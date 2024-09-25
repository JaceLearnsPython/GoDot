extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# record we played so we don't keep getting the name
	var title_node = get_node("Background/Title")
	var player_score_node = get_node("Background/player_score")
	var player_time_node = get_node("Background/player_time")
	
	# adjust the game end screen (defaults to "Game over!")
	if ChangeToSinglePlayer.player_won:
		title_node.text = ChangeToSinglePlayer.player_name + " Won!"
	else:
		title_node.text = ChangeToSinglePlayer.player_name + " Lost!"
	
	# change the score regardless of who won	
	var str_score = ChangeToSinglePlayer.score
	var str_time_taken = ChangeToSinglePlayer.time_taken
	str_score = str(str_score)
	str_time_taken = str(str_time_taken)
	player_score_node.text += str_score
	player_time_node.text += str_time_taken + " sec"
	
