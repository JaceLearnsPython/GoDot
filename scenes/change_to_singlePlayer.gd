extends Button

# Called when the node enters the scene tree for the first time.

#
func _physics_process(_delta: float) -> void:
	pass # nothing yet

func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/SinglePlayer.tscn")
