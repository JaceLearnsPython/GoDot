extends HFlowContainer

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/game_end.tscn")
