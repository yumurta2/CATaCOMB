extends Node
const YARN = preload("res://collectible/yarn/yarn.tscn")
const BIG_RED_MOB = preload("res://enemies/big_red_mob/big_red_mob.tscn")
var tangled_yarns = 32
var process : Dictionary
var potions = 0

func _ready():
	pass
func decres_potions():
	potions-=1
func get_potions():
	return potions
func get_yarns():
	return tangled_yarns
func set_yarns():
	tangled_yarns+=1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func new_loot(posX, posY):
	var rasgele = randi_range(0,3)
	if rasgele == 0:
		var yarn_instance = YARN.instantiate() 
		add_child(yarn_instance)
		yarn_instance.position = Vector2(posX+5, posY)
		var yarn_instance2 = YARN.instantiate() 
		add_child(yarn_instance2)
		yarn_instance2.position = Vector2(posX, posY+5)
	elif rasgele == 1:
		var yarn_instance = YARN.instantiate() 
		add_child(yarn_instance)
		yarn_instance.position = Vector2(posX, posY)
	elif rasgele == 2:
		var brm_instance = BIG_RED_MOB.instantiate() 
		add_child(brm_instance)
		brm_instance.position = Vector2(posX, posY)
	elif rasgele ==3:
		pass
func sell_tangled_yarns():
	process = custom_mod(tangled_yarns)
	tangled_yarns = process.remainder
	potions += process.divisions

func custom_mod(a: int):
	var b = 5
	var count := 0
	var original_a := a
	while a >= b:
		a -= b
		count += 1
	return {"remainder": a, "divisions": count}


func _on_timer_timeout():
	pass # Replace with function body.
