extends Node

@export var enemy_scene: PackedScene

func _ready():
	pass

func respawn_enemy(position, delay):
	var timer = Timer.new()
	timer.wait_time = delay
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_respawn_timeout").bind(position))
	add_child(timer)
	timer.start()

func _on_respawn_timeout(position):
	var enemy_instance = enemy_scene.instance()
	enemy_instance.global_position = position
	get_parent().add_child(enemy_instance)
