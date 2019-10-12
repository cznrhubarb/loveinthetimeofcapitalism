extends Sprite

var line_items = []

func create_order(icon, time):
	var scn = load("res://scn/RequestLineItem.tscn")
	var line_item = scn.instance()
	line_item.time_remaining = time
	line_item.position.y += 16 * line_items.size()
	add_child(line_item)
	line_items.append(line_item)

func _on_Timer_timeout():
	print("timeout")
	create_order("notebook", 64)
