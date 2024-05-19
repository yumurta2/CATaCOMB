extends Node
const YARN = preload("res://collectible/yarn/yarn.tscn")
var tangled_yarns = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		pass
	elif rasgele ==3:
		pass
