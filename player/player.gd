extends CharacterBody2D
#selam
@onready var animated_sprite = $AnimatedSprite2D

@export var WALK_SPEED = 100.0
@export var ROLL_SPEED = 300.0
const ROLL_TIME = 0.3
var last_direction
var dodging = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var directionX 
var directionY
func _physics_process(delta):

	if not dodging:
		directionX = Input.get_axis("move_left", "move_right")
		directionY = Input.get_axis("move_up", "move_down")

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
			velocity.x = directionX * WALK_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		if directionY:
			velocity.y = directionY * WALK_SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, WALK_SPEED)

		if Input.is_action_just_pressed("roll"):
			dodge(last_direction)
			dodging = true
			await get_tree().create_timer(ROLL_TIME).timeout  # adjust the time as needed
			dodging = false
	move_and_slide()
func dodge(last_direction):
	if last_direction == "left":
		animated_sprite.play("roll_right")
		animated_sprite.flip_h = true
		velocity.x = -1 * ROLL_SPEED
	elif last_direction == "right":
		animated_sprite.play("roll_right")
		animated_sprite.flip_h = false
		velocity.x = 1 * ROLL_SPEED
	elif last_direction == "up":
		velocity.y = -1 * ROLL_SPEED
	elif last_direction == "down":
		velocity.y = 1 * ROLL_SPEED
	
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
