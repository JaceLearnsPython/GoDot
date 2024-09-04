extends Button

# change the scene to the main menu
func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
