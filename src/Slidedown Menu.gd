extends Sprite

var line_items = []

var line_item_start_pos = Vector2(-230, -150)

func create_order(icon, time):
	var scn = load("res://scn/RequestLineItem.tscn")
	var line_item = scn.instance()
	line_item.time_remaining = time
	line_item.position = line_item_start_pos
	line_item.position.y += 16 * line_items.size()
	add_child(line_item)
	line_items.append(line_item)
	
	# three columns
	# aisle
	# overdue

func _on_Timer_timeout():
	create_order("notebook", 64)
