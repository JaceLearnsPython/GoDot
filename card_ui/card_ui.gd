extends Node2D

var mouse_in = false
var selected = false
var in_droppable
var og_pos: Vector2
var area_node
var card_num
var played = false


func _ready():
	og_pos = position

func _process(delta):
	if in_droppable and not selected and $TextureRect.texture != null:
		card_played()
			
func card_played():
		card_num = str($TextureRect.texture.get_path())
		var played_card = card_num
		card_num = card_num.split("_")
		
		# check if it is an empty stack
		if area_node.texture == null:
			if card_num[2].contains("01.png"):
				area_node.texture = $TextureRect.texture
				played = true
				return

				
		# otherwise there is a card
		if area_node.texture != null:
			var node_str = str(area_node.texture.get_path())
			node_str = node_str.split("_") # split it so its [0]=path, [1] = suit [2] = num.png
			# check if we can play it 
			var num = card_num[2].split(".")
			
			var node_num = int(node_str[2].split(".")[0])
			num = int(num[0]) # get it as an int
			
			if num == (node_num+1) and node_str[1] == card_num[1]:
				area_node.texture = $TextureRect.texture
				played = true
				return

# handle input for card dragging
func _input(event):
	if Input.is_action_just_pressed("left-click") and mouse_in:
		selected = true
		
		# make it always on top of the other cards.
		z_index = 2
		$TextureRect.z_index = 2
		
	if Input.is_action_just_released("left-click"):
		selected = false
		position = og_pos
	
func _on_area_2d_mouse_entered():
	mouse_in = true

func _on_area_2d_mouse_exited():
	mouse_in = false

func _on_area_2d_area_entered(area):
	
	# get the name of the node we entered
	var name = str(area)
	name = name.split(":")
	name = name[0]
	name = "%" + name + "/TextureRect"	
	area_node = get_node(name)
	
	in_droppable = true

func _on_area_2d_area_exited(area):
	in_droppable = false

	
	
	
	
