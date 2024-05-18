extends CharacterBody2D
const speed = 30
var time_accumulator = 0.0
var update_interval = 0.5
var directionX = 0
var directionY = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

 #asd
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	if directionX:
		velocity.x = directionX * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if directionY:
		velocity.y = directionY * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()

	time_accumulator += delta
	if time_accumulator >= update_interval:
		time_accumulator -= update_interval
		perform_update(delta)
		
func perform_update(delta):
	directionX = randi_range(-1,1)
	directionY = randi_range(-1,1)
func damage(num):
	pass
