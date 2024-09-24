extends Node2D


@onready var timer = $Timer
@onready var label = $display_time

func _ready():
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_left = time_left()
	if time_left <= 1:
		label.text = "GAME START"
		return
	label.text = "%01d" % time_left

func time_left():
	var time_left = timer.time_left
	if time_left <= 0 and self.visible:
		self.visible = false
		get_tree().paused = false
	return time_left
