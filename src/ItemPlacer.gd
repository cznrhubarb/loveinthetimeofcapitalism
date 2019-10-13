extends Node2D

var item_list = [
	"alarm",
	"alembic",
	"bomb",
	"brick",
	"broom",
	"camera",
	"coffin",
	"computer",
	"crystalball",
	"dolls",
	"extinguisher",
	"gear",
	"gun",
	"hammer",
	"joystick",
	"knife",
	"lightbulb",
	"luggage",
	"magnet",
	"microscope",
	"moai",
	"notebook",
	"oildrum",
	"painting",
	"radio",
	"scissors",
	"teddy",
	"toilet",
	"triangleruler",
	"tv",
]
var aisle_lookup = {}

# Plan is that all bins will call this function in their _ready func and give the ItemPlacer their aisle name
func place_random_item(put_in_this_aisle):
	var rand_index = randi() % item_list.size()
	var item_name = item_list[rand_index]
	aisle_lookup[item_name] = put_in_this_aisle
	item_list.remove(rand_index)
	return item_name

func get_aisle(item_type):
	if aisle_lookup.has(item_type):
		return aisle_lookup[item_type]
	else:
		return "?"

func get_random_item():
	var available_items = aisle_lookup.keys()
	return "hammer"
	# Below is the correct code, once the bins are placing their items inside
	#return available_items[randi() % available_items.size()]