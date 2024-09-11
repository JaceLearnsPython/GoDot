extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("LOADED")
	var sw_result = await SilentWolf.Scores.get_scores(0, "testing").sw_get_scores_complete
	display_scores(sw_result)
	
func display_scores(sw_result):
	print(sw_result.scores)
	var score_data = sw_result.scores
	var score = score_data[0]["score"]
	var player_name = score_data[0]["player_name"]
	var time_score = score_data[0]["metadata"]["time"]
	$Background/player_name.text += player_name
	$Background/player_score.text += str(score)
	print("Score: " + str(score) + "\nName: " + str(player_name) + "\nTime:" + str(time_score))
	
