extends Node2D

var time_remaining
onready var label = get_node("TimeRemaining")

func _process(delta):
	time_remaining -= delta
	#TODO Make this look like a clock number
	label.text = "Due in " + str(ceil(time_remaining))