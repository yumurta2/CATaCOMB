extends Node2D
@onready var game_manager = $"../../GameManager"

@onready var shaman_buble = $shaman_buble

var is_player_range = false
var is_first = true
var dialog_first = [
	"Ah, so you're the savior everyone's 'yarning' about.",
	"Bring me your tangled troubles, and I'll weave them into solutions."
]
var dialog = [
	"You've found more yarn?",
	"May your threads always untangle and your knots be ever in your favor!"
]
var show =  0
func _ready():
	shaman_buble.hide()

func _process(delta):
	pass


func interact():
	if is_player_range and is_first:
		shaman_buble.show()
		shaman_buble.text = dialog_first[show]
		show+=1
		if show>1:
			is_first = false
	elif is_player_range and show == 31:
		shaman_buble.text = dialog[1]
		sell_yarns()

func _on_area_2d_body_entered(body):
	is_player_range = true
	if not is_first:
		shaman_buble.text = dialog[0]
		shaman_buble.show()
		show=31

func _on_area_2d_body_exited(body):
	is_player_range = false 
	shaman_buble.text = ""
	shaman_buble.hide()

func sell_yarns():
	game_manager.sell_tangled_yarns()
