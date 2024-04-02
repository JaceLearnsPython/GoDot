extends Node2D

var dragging = false
var mouse_in = false
var newPos: Vector2
var draggingDistance
var dir

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var cardSize = size
	#$Area2D/CardCollision.scale = cardSize

	# This works for checking if a node is draggable.
	#var card = get_node("Player1/CardUI1")
	#print(card.is_in_group("draggable"))

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			newPos = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging = false
			
	elif event is InputEventMouseMotion:
		if dragging:
			newPos = get_viewport().get_mouse_position() - draggingDistance * dir

func _physics_process(delta):
	if dragging:
			move_child($".", 200)
		#move_and_slide((newPos - position) * Vector2(30, 30))

	
func _process(delta):
	pass	

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
