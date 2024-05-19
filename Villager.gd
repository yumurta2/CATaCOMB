extends Node2D

@export var message: String = "Merhaba, ben bir köylüyüm!"

@onready var label = $Label
@onready var area = $Area2D

func _ready():
	label.text = message
	label.visible = false
	area.connect("body_entered", Callable(self, "_on_area_entered"))
	area.connect("body_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(body):
	if body.is_in_group("player"):
		label.visible = true

func _on_area_exited(body):
	if body.is_in_group("player"):
		label.visible = false
