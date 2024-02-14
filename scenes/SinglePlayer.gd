extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	if is_pressed():
		get_tree().change_scene_to_file("res://scenes/SinglePlayer.tscn")
		print("Changed Scene to Single Player, make sure to remove this after debugging!")
