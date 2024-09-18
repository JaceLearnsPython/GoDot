extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# record we played so we don't keep getting the name
	var title_node = get_node("Background/Title")
	var player_score_node = get_node("Background/player_score")
	
	# adjust the game end screen (defaults to "Game over!")
	if ChangeToSinglePlayer.player_won:
		title_node.text = ChangeToSinglePlayer.player_name + " Won!"
	else:
		title_node.text = ChangeToSinglePlayer.player_name + " Lost!"
	
	# change the score regardless of who won	
	var str_score = ChangeToSinglePlayer.score
	str_score = str(str_score)
	player_score_node.text += str_score
	
	
	# get the data
	var sw_result = await SilentWolf.Scores.get_scores(0, "testing").sw_get_scores_complete
	display_scores(sw_result)
	
# need to update in case no data is returned
func display_scores(sw_result):
	print(sw_result.scores)
	var score_data: Array = sw_result.scores
	
	# make sure the data is not null
	if score_data.size() <= 0:
		return
		
	# Will need to loop through and display all 10 possible scores. This is just for testing ATM.
	var score = score_data[0]["score"]
	var player_name = score_data[0]["player_name"]
	var time_score = score_data[0]["metadata"]["time"]
	print("Score: " + str(score) + "\nName: " + str(player_name) + "\nTime:" + str(time_score))	
	
