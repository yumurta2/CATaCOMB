extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var health_bar = $"/root/Game/UI/Control/HealthBar"
@onready var potions_label = $"/root/Game/UI/Control/Label"
@onready var yarns_label = $"/root/Game/UI/Control/Label2"

@onready var game_manager = $"../GameManager"
@onready var animation_player = $AnimationPlayer

@onready var hit_zone = $DamageZone/hit_zone
@onready var shaman = $"../Npcs/Shaman"  # Shaman node'unu buraya tanımlayın

@export var WALK_SPEED = 100.0
@export var ROLL_SPEED = 300.0
const ROLL_TIME = 0.3
const ROLL_COOLDOWN = 3.0
var last_direction = "right"
var dodging = false
var can_dodge = true
var directionX
var directionY
var maxHealth = 100
var currentHealth = 100
var potions = 0

func _ready():
	update_ui()

func _physics_process(delta):
	if Input.is_action_just_pressed("drink_pot"):
		if potions > 0:
			game_manager.decrease_potions()
			currentHealth = clamp(currentHealth + 10, 0, maxHealth)
			update_ui()

	if not dodging:
		directionX = Input.get_axis("move_left", "move_right")
		directionY = Input.get_axis("move_up", "move_down")
		if Input.is_action_just_pressed("interact"):
			shaman.interact()

		if directionX == -1:
			last_direction = "left"
		elif directionX == 1:
			last_direction = "right"
		elif directionY == -1:
			last_direction = "up"
		elif directionY == 1:
			last_direction = "down"

		if directionX == 0 and directionY == 0:
			change_animation("idle")
		else:
			change_animation("walk")

		if directionX:
			velocity.x = directionX * WALK_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		if directionY:
			velocity.y = directionY * WALK_SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, WALK_SPEED)

		if Input.is_action_just_pressed("roll"):
			if can_dodge:
				dodge()
			dodging = true
			await get_tree().create_timer(ROLL_TIME).timeout
			dodging = false
		if Input.is_action_just_pressed("light_attack"):
			light_attack()
			dodging = true
			await get_tree().create_timer(0.3).timeout
			dodging = false

	update_ui()
	move_and_slide()

func update_ui():
	health_bar.value = currentHealth
	health_bar.max_value = maxHealth
	potions_label.text = str(game_manager.get_potions())
	yarns_label.text = str(game_manager.get_yarns())

func dodge():
	can_dodge = false
	dodging = true
	play_dodge_animation()
	await get_tree().create_timer(ROLL_TIME).timeout
	dodging = false
	await cooldown()

func play_dodge_animation() -> void:
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

func cooldown() -> void:
	await get_tree().create_timer(ROLL_COOLDOWN).timeout
	can_dodge = true

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
		animated_sprite.play("up_light_attack")
		animated_sprite.flip_h = false
		velocity.x = 0
		velocity.y = 0
	elif last_direction == "down":
		animation_player.play("down_light_attack")
		animated_sprite.play("down_light_attack")
		animated_sprite.flip_h = false
		velocity.x = 0
		velocity.y = 0

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
		animated_sprite.play(anim + "_down")

func damage(num):
	currentHealth -= clamp(num, 0, maxHealth)
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
