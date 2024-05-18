extends CharacterBody2D
#selam
#AS
@onready var animated_sprite = $AnimatedSprite2D
@onready var label_health = $Label_Health
@onready var label_tangled_yarns = $Label_Tangled_Yarns

@onready var game_manager = $"../GameManager"
@onready var animation_player = $AnimationPlayer

@onready var hit_zone = $DamageZone/hit_zone

@export var WALK_SPEED = 100.0
@export var ROLL_SPEED = 300.0
const ROLL_TIME = 0.3
var last_direction = "right"
var dodging = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var directionX
var directionY
var maxHealth = 100
var currentHealth = 100
func _ready():
	label_health.text = "HP:" + str(currentHealth)
	label_tangled_yarns.text = "tangled yarns:" +str(game_manager.get_yarns())
func _physics_process(delta):
	label_tangled_yarns.text = "tangled yarns:" + str(game_manager.get_yarns())
	label_health.text = "HP:" + str(currentHealth)
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
		
		if directionX == 0 and directionY == 0:
			change_animation(  "idle")
		else:
			change_animation(  "walk")

		if directionX:
			velocity.x = directionX * WALK_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		if directionY:
			velocity.y = directionY * WALK_SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, WALK_SPEED)

		if Input.is_action_just_pressed("roll"):
			dodge()
			dodging = true
			await get_tree().create_timer(ROLL_TIME).timeout  # adjust the time as needed
			dodging = false
		if Input.is_action_just_pressed("light_attack"):
			light_attack()
			dodging = true
			await get_tree().create_timer(0.3).timeout  # adjust the time as needed
			dodging = false
	move_and_slide()
func dodge():
	if last_direction == "left":
		animated_sprite.play("roll_right")
		animated_sprite.flip_h = true
		velocity.x = -1 * ROLL_SPEED
	elif last_direction == "right":
		animated_sprite.play("roll_right")
		animated_sprite.flip_h = false
		velocity.x = 1 * ROLL_SPEED
	elif last_direction == "up":
		animated_sprite.play("roll_up")
		animated_sprite.flip_h = false
		velocity.y = -1 * ROLL_SPEED
	elif last_direction == "down":
		animated_sprite.play("roll_down")
		animated_sprite.flip_h = false
		velocity.y = 1 * ROLL_SPEED
func light_attack():
	if last_direction == "left":
		animation_player.play("left_light_attack")
		animated_sprite.play("right_light_attack")
		animated_sprite.flip_h = true
		velocity.x = 0
		velocity.y = 0
	elif last_direction == "right":
		animation_player.play("right_light_attack")
		animated_sprite.play("right_light_attack")
		animated_sprite.flip_h = false
		velocity.x = 0
		velocity.y = 0
	elif last_direction == "up":
		animation_player.play("up_light_attack")
		animated_sprite.flip_h = false
	elif last_direction == "down":
		animation_player.play("down_light_attack")
		animated_sprite.flip_h = false
func change_animation(anim):
	if last_direction == "left":
		animated_sprite.flip_h = true
		animated_sprite.play(anim + "_right")
	elif last_direction == "right":
		animated_sprite.flip_h = false
		animated_sprite.play(anim + "_right")
	elif last_direction == "up":
		animated_sprite.flip_h = false
		animated_sprite.play(anim + "_up")
	elif last_direction == "down":
		animated_sprite.flip_h = false
		animated_sprite.play(anim +"_down")
func damage(num):
	currentHealth -= clamp(num , 0 ,maxHealth)
	dodging = true
	animated_sprite.play("damage")
	await get_tree().create_timer(0.2).timeout
	dodging = false
	if currentHealth <= 0:
		die()
func die():
	set_physics_process(false)
	animated_sprite.play("death")
	await get_tree().create_timer(0.6).timeout
	get_tree().reload_current_scene()
