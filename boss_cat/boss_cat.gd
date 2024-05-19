extends CharacterBody2D
const speed = 100
var time_accumulator = 0.0
var update_interval = 0.5
var directionX = 0
var directionY = 0
@onready var animated_sprite = $AnimatedSprite2D
@onready var label = $Label
var boss_text = [
	"You think you can untangle my plans? Think again, yarn thief!",
	"Prepare to be clawed back to reality!",
	"Did you really think you could just waltz in and knit-pick my treasures?",
	"Paws off my yarn, or you'll be in a world of hurt!",
	"This isn't a game of cat and mouse... or maybe it is!",
	"My wrath will unravel you!"
]
var text_num = 0
var maxHealth = 500
var currentHealth = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#asd
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):

	label.text = boss_text[text_num]
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
	if directionX ==  1:
		animated_sprite.play("attack1")
	elif directionX == 0:
		animated_sprite.play("attack2")
	elif directionX == -1:
		animated_sprite.play("attack3")

func perform_update(delta):
	directionX = randi_range(-1,1)
	directionY = randi_range(-1,1)
func damage(num):
	text_num = (text_num +1) % 5
	currentHealth -= clamp(num , 0 ,maxHealth)
	animated_sprite.modulate = Color(1, 0, 0) # Beyaza dön
	await get_tree().create_timer(0.2).timeout
	animated_sprite.modulate = Color(1, 1, 1) # Eski haline dön
	if currentHealth <= 0:
		die()
func die():
	set_physics_process(false)
	queue_free()
