extends Button
# THIS SCRIPT IS GLOBAL. USED BY SINGLEPLAYER TO TELL WHAT MODE IT IS
# GoDot does not have global variables like most languages do. 

# Set Delay
# 140 = Easy
# 90 = Normal
# 50 = Hard 

# global variables for game end and tracking scores
static var time_delay
static var player_name
static var score
static var player_won: bool
static var played: bool

func _on_pressed():
	played = true # record we have a name / they played
	var node = get_node(".")
	time_delay = 0
	
	if node.to_string().contains("easy"):
		time_delay = 150
	elif node.to_string().contains("normal"):
		time_delay = 100
	else:
		time_delay = 50
		
	
	get_tree().change_scene_to_file("res://scenes/SinglePlayer.tscn")
