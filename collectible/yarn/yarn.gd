extends Area2D
@onready var animation_player = $AnimationPlayer

@onready var game_manager = $".."



func _on_body_entered(body):
	game_manager.set_yarns()
	animation_player.play("pick_up")
	queue_free()
func damage():
	pass
