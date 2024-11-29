extends StaticBody2D

func collect_coin(body: Node2D) -> void:
	if body is Player:
		Globals.inventory_add_coins(1)
		queue_free()
