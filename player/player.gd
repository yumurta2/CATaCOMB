extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var SPEED = 100.0
var last_direction
# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):
	# Add the gravity.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("move_left", "move_right")
	var directionY = Input.get_axis("move_up", "move_down")
	
	if directionX == -1:
		last_direction = "left"
	elif directionX == 1:
		last_direction = "right"
	elif directionY == -1:
		last_direction = "up"
	elif directionY == 1:
		last_direction = "down"
	change_animation(last_direction)
		
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
func change_animation(last_direction):
	if last_direction == "left":
		animated_sprite.flip_h = true
		animated_sprite.play("walk_right")
	elif last_direction == "right":
		animated_sprite.flip_h = false
		animated_sprite.play("walk_right")
	elif last_direction == "up":
		animated_sprite.flip_h = false
		animated_sprite.play("walk_up")
	elif last_direction == "down":
		animated_sprite.flip_h = false
		animated_sprite.play("walk_down")
