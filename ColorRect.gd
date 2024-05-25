extends Node

var reload_timer = Timer.new()

func _ready():
	# Set up the timer
	reload_timer.wait_time = 1.0  # Wait time in seconds
	reload_timer.one_shot = false  # Repeating timer
	add_child(reload_timer)
	reload_timer.start()

	# Connect the timer's timeout signal to the reload function
	reload_timer.connect("timeout", self, "reloadNode")

# Function to reload a node
func reloadNode():
	var node_to_reload = get_node("Path/To/Node")  # Replace "Path/To/Node" with the actual path
	if node_to_reload != null:
		# Reload or update the node as needed
		# For example, if it's a scene:
		var scene = ResourceLoader.load(node_to_reload.filename)
		if scene != null:
			node_to_reload.queue_free()  # Remove the existing node
			add_child(scene.instance())  # Add the reloaded scene
