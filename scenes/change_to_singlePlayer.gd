extends Button

# Set Delay, 140 = Easy, 90 = Normal, 50 = Hard 
# get what mode and change scene to game
#signal mode_update(delay)
func _on_pressed():
	var node = get_node(".")

	if node.to_string().contains("easy"):
		print("Easy mode!")
		#ai_Script.delay = 140
	elif node.to_string().contains("normal"):
		print("Normal mode!")
		#ai_Script.delay = 90
	else:
		print("Hard Mode!")
		#ai_Script.delay = 50
		
			
	get_tree().change_scene_to_file("res://scenes/SinglePlayer.tscn")
