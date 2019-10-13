extends Sprite

# more or less constants
var items_per_column = 17
var line_item_start_pos = Vector2(-230, -150)
var column_width = 165
var row_height = 20

onready var placer = get_tree().get_root().find_node("ItemPlacer", true, false)

var line_items = []

func create_order(icon, time):
	var scn = load("res://scn/RequestLineItem.tscn")
	var line_item = scn.instance()
	line_item.init(icon, time)
	
	var column = line_items.size() / items_per_column
	var row = line_items.size() % items_per_column
	line_item.position = line_item_start_pos
	line_item.position.x += column_width * column
	line_item.position.y += row_height * row
	
	add_child(line_item)
	line_items.append(line_item)

func _on_Timer_timeout():
	randomize()
	create_order(placer.get_random_item(), rand_range(60, 90))
	get_node("OrderUpSound").play()