extends LineEdit

func _ready():
	if ChangeToSinglePlayer.played:
		%display_name.text += ChangeToSinglePlayer.player_name
		get_node(".").queue_free()

func _on_text_submitted(new_text):
	var get_name_node = get_node(".")
	var player_name = new_text.to_upper() # make it all caps
	
	# prevent empty names
	if player_name.length() <= 0:
		get_name_node.placeholder_text = "All who enter must type at least a character :)"
		return
	player_name.strip_edges() # trim whitespace
	ChangeToSinglePlayer.player_name = player_name
	%display_name.text += player_name
	get_name_node.visible = false # hide the LineEdit node
