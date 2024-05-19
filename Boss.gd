extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_area = $Area2D

@export var WALK_SPEED = 100.0
@export var ATTACK_COOLDOWN = 2.0
@export var maxHealth = 200
var currentHealth = maxHealth
var attack_ready = true

var player = null

func _ready():
	attack_area.connect("body_entered", Callable(self, "_on_attack_area_entered"))
	player = get_tree().get_root().get_node("Game/Player")  # Oyuncuyu bul

func _physics_process(delta):
	if player != null:
		move_toward_player()

	if player != null and attack_ready:
		if is_player_below():
			attack()

	move_and_slide()

func move_toward_player():
	var direction = (player.global_position - global_position).normalized()
	direction.y = 0  # Sadece sağa ve sola hareket
	velocity.x = direction.x * WALK_SPEED

	if direction.x > 0:
		animated_sprite.play("walk_right")
	elif direction.x < 0:
		animated_sprite.play("walk_left")
	else:
		animated_sprite.play("idle")

func is_player_below() -> bool:
	return player.global_position.y > global_position.y

func attack() -> void:
	attack_ready = false
	animated_sprite.play("attack_down")
	await get_tree().create_timer(ATTACK_COOLDOWN).timeout
	attack_ready = true

func _on_attack_area_entered(body):
	if body.is_in_group("player") and animated_sprite.frame == 5:  # Belirli bir frame kontrolü
		if body.has_method("damage"):
			body.damage(10)

func damage(amount):
	currentHealth -= amount
	if currentHealth <= 0:
		die()

func die():
	animated_sprite.play("death")
	queue_free()  # Boss'u sahneden kaldır
