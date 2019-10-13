extends Sprite

# TODO set a local aisle id var
var aisle_id = "A"
var item_type = ""

onready var tween = get_tree().get_root().find_node("HUDTween", true, false)
onready var menu = get_tree().get_root().find_node("BinContentsMenu", true, false)
# TODO find itemplacer node

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO call itemplacer method to retrieve bin contents
	# item_type = itemplacer.place_random_item(aisle_id)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# TODO implement _input listener to add bin contents to inventory
# func _input(event):
#    if event.is_action_pressed("pickup_item"):
#       inventory.add_item(item_type)


func _on_Area2D_body_entered(body):
	# Ignore the Wall's collision
	if body == get_parent().get_node("Wall/StaticBody2D"):
		return
	tween.interpolate_property(menu, "position", Vector2(530, -400), Vector2(530, 200), .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
	# TODO call the menu's icon fill function
	menu.fill_with_icon(item_type)
	get_node("OutSound").play()

func _on_Area2D_body_exited(body):
	tween.interpolate_property(menu, "position", Vector2(530, 200), Vector2(530, -400), .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
	get_node("InSound").play()
