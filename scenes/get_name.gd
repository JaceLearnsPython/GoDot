extends LineEdit



func _on_text_submitted(new_text):
	var get_name_node = get_node(".")
	var player_name = new_text.to_upper() # make it all caps
	player_name.strip_edges() # trim whitespace
	ChangeToSinglePlayer.player_name = player_name
	print(player_name)
	%display_name.text += player_name
	get_name_node.visible = false

