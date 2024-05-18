extends Node2D
const speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	var directionX = randi_range(-1,1)
	var directionY = randi_range(-1,1)
	position.x += directionX * speed * delta
	position.y += directionY * speed * delta
