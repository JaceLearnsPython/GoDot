extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	display_data()
	

func display_data():
	
	# get data
	var sw_result = await SilentWolf.Scores.get_scores(0, "test").sw_get_scores_complete
	print(sw_result.scores)
	var score_data: Array = sw_result.scores
	
	# make sure the data is not null
	if score_data.size() <= 0:
		var name_l = Label.new()
		name_l.text = ChangeToSinglePlayer.player_name
		add_child(name_l)
		
		var score_l = Label.new()
		score_l.text = str(ChangeToSinglePlayer.score)
		%score_container.add_child(score_l)
		
		var time_l = Label.new()
		time_l.text = str(ChangeToSinglePlayer.time_taken)
		%time_container.add_child(time_l)
		return
	
	# create 10 lables for top scores
	for i in range(10):
		if i < len(score_data):
			var new_label = Label.new()
			new_label.text = str(i+1) + ". " + score_data[i]["player_name"]
			add_child(new_label)
	
	# do it again for score
	var score_container = %score_container
	for i in range(10):
		if i < len(score_data):
			var new_label = Label.new()
			new_label.text = str(score_data[i]["score"])
			score_container.add_child(new_label)

	# once more for time
	var time_container = %time_container
	for i in range(10):
		if i < len(score_data):
			var new_label = Label.new()
			new_label.text = str(score_data[i]["metadata"]["time"])
			time_container.add_child(new_label)
