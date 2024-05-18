extends Area2D
@onready var animation_player = $AnimationPlayer


func _on_body_entered(body):
	print("body entered")
	animation_player.play("pick_up")

func damage():
	pass
