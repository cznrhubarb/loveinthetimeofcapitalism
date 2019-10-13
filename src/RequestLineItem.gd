extends Node2D

var time_remaining
var type
onready var label = get_node("TimeRemaining")

func init(item_type, time):
	type = item_type
	time_remaining = time

func _ready():
	#get_node("Icon").texture = 
	var placer = get_tree().get_root().find_node("ItemPlacer", true, false)
	get_node("Aisle").text = placer.get_aisle(type)

func _process(delta):
	time_remaining -= delta
	var total_seconds = int(ceil(time_remaining))
	
	if total_seconds >= 0:
		var minutes = total_seconds / 60
		var seconds = total_seconds % 60
		if seconds < 10:
			seconds = "0" + str(seconds)
		label.text = "Due in " + str(minutes) + ":" + str(seconds)
	else:
		var frac = time_remaining - int(time_remaining)
		if frac > -0.75 or (frac > -0.25 and frac < -0.5):
			label.text = "OVERDUE"
		else:
			label.text = ""
		label.add_color_override("default_color", Color(78, 0, 0))