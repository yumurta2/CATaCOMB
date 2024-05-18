extends AnimatableBody2D
var health = 30
@onready var animated_sprite_2d = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(num):
	health -= num
	if health <= 0:
		patla()
func patla():
	animated_sprite_2d.play("opened")
