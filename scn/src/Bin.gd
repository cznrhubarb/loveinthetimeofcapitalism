extends Sprite

var on_screen_pos = Vector2(2040, 1120)
var off_screen_pos = Vector2(2040, -1280)

var aisle_id = ""
var item_type = ""

onready var tween = get_tree().get_root().find_node("HUDTween", true, false)
onready var menu = get_tree().get_root().find_node("BinContentsMenu", true, false)
onready var worker = get_tree().get_root().find_node("Worker", true, false)
onready var item_placer = get_tree().get_root().find_node("ItemPlacer", true, false)

func init(aisle):
	aisle_id = aisle
	item_type = item_placer.place_random_item(aisle)

func _on_Area2D_body_entered(body):
	# Ignore the Wall's collision
	if body == get_parent().get_node("Wall/StaticBody2D"):
		return
	tween.interpolate_property(menu, "position", off_screen_pos, on_screen_pos, .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
	# TODO call the menu's icon fill function
	menu.fill_with_icon(item_type)
	get_node("OutSound").play()
	worker.touching_bin = self

func _on_Area2D_body_exited(body):
	tween.interpolate_property(menu, "position", on_screen_pos, off_screen_pos, .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
	get_node("InSound").play()
	worker.touching_bin = null
