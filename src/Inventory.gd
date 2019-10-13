extends Node2D

# more or less constants
var bottom_left_corner = Vector2(3950, 2520)
var icon_size = 250
onready var icon_scene = load("res://scn/InventoryItem.tscn")

var items_held = []
var spent_items = []

func add_item(item):
	var icon = icon_scene.instance()
	icon.init(item)
	icon.position = bottom_left_corner
	items_held.push_front(icon)
	add_child(icon)
	adjust_item_positions()

func adjust_item_positions():
	for i in range(0, items_held.size()):
		var item = items_held[i]
		item.set_desired_position(bottom_left_corner - Vector2(0, (i+1) * icon_size))

func try_remove_item(item_type):
	for i in range(0, items_held.size()):
		var item = items_held[i]
		if item.type == item_type:
			items_held.remove(i)
			item.set_desired_position(item.position + Vector2(icon_size, 0))
			spent_items.append(item)
			adjust_item_positions()
			return true
	return false

func _process(delta):
	for item in spent_items:
		var delta_vec = item.desired_position - item.position
		if delta_vec.length() < 0.25:
			spent_items.erase(item)
			remove_child(item)