extends ColorRect

func _on_resume_pressed():
	get_tree().paused = false
	hide()


func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

