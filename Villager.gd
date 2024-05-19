extends Node2D

@export var message: String = "Merhaba, ben bir köylüyüm!"

@onready var label = $Label
@onready var area = $Area2D

func _ready():
	label.text = message
	label.visible = false




func _on_area_2d_body_entered(body):
	if body is CharacterBody2D and body.name == "Player":
		label.visible = true # Replace with function body.



func _on_area_2d_body_exited(body):
	label.visible = false # Replace with function body.
