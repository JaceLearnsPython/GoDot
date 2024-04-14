extends Node2D

var mouse_in = false
var selected = false
var in_droppable
var og_pos: Vector2
var area_node
var card_num


func _ready():
	og_pos = position

func _process(delta):
	if in_droppable and not selected:
		card_num = str(area_node)
		print(card_num)
		
		if area_node.texture == null:
			# check if an Ace!
			area_node.texture = $TextureRect.texture

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
