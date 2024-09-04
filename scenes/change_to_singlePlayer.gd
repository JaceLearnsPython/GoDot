extends Button

# Set Delay
# 140 = Easy
# 90 = Normal
# 50 = Hard 

# get what mode and change scene to game
static var time_delay

func _on_pressed():
	var node = get_node(".")
	time_delay = 0
	
	if node.to_string().contains("easy"):
		print("Easy mode!")
		time_delay = 140
	elif node.to_string().contains("normal"):
		print("Normal mode!")
		time_delay = 90
	else:
		print("Hard Mode!")
		time_delay = 50
		
	
	get_tree().change_scene_to_file("res://scenes/SinglePlayer.tscn")
