extends Node2D

var mouse_in = false
var selected = false
var in_droppable
var og_pos: Vector2

func _ready():
	og_pos = position

func _process(delta):
	pass

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

