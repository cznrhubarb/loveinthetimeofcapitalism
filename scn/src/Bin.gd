extends Sprite

# TODO set a local bin var for item_type, set by constructor
var item_type = "NOTEBOOK"

# TODO add constructor

onready var tween = get_tree().get_root().find_node("HUDTween", true, false)
onready var menu = get_tree().get_root().find_node("BinContentsMenu", true, false)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	# Ignore the Wall's collision
	if body == get_parent().get_node("StaticBody2D"):
		return
	tween.interpolate_property(menu, "position", Vector2(530, -400), Vector2(530, 200), .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
	# TODO call the menu's icon fill function
	menu.fill_with_icon(item_type)

func _on_Area2D_body_exited(body):
	tween.interpolate_property(menu, "position", Vector2(530, 200), Vector2(530, -400), .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
