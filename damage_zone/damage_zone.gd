extends Area2D

@onready var where = $".."

func _ready():
	print(where)
func _on_body_entered(body):
	body.damage(10)
