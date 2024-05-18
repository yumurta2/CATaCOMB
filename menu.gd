extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#get_tree().change_scene_to_file("res://scene/intro/intro.tscn")

func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://game.tscn")


func _on_quit_pressed():
	get_tree().quit()
