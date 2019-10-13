extends Node2D

func _ready():
	var aisle = name.right(name.length()-1)
	get_node("Bin1").init(aisle)
	get_node("Bin2").init(aisle)
	get_node("Bin3").init(aisle)
	get_node("Bin4").init(aisle)
	get_node("Bin5").init(aisle)
