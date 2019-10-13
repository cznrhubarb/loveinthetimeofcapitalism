extends Sprite

onready var orders = get_tree().get_root().find_node("Slidedown Menu", true, false)
onready var inventory = get_tree().get_root().find_node("Inventory", true, false)

func _on_Area2D_body_entered(body):
	if body == get_parent().get_node("Box/StaticBody2D"):
		return
	
	# Check to see if we have the items we need and ship whatever we can
	var number_shipped = 0
	for order in orders.line_items:
		if inventory.try_remove_item(order.type):
			number_shipped += 1
	
	if number_shipped > 0:
		get_node("AnimationPlayer").play("ShipIt")

func _on_Area2D_body_exited(body):
	pass # Replace with function body.
