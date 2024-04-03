extends Node2D

var mouse_in = false
var selected = false
var in_droppable

func _process(delta):
	pass

# handle input for card dragging
func _input(event):
	if Input.is_action_just_pressed("left-click") and mouse_in:
		selected = true
	if Input.is_action_just_released("left-click"):
		selected = false
	
func _on_area_2d_mouse_entered():
	mouse_in = true

func _on_area_2d_mouse_exited():
	mouse_in = false

