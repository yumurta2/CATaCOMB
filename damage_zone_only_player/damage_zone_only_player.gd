extends Area2D

@onready var where = $".."

func _ready():
	pass

func _on_body_entered(body):
	if body is CharacterBody2D and body.name == "Player":
		body.damage(20)
