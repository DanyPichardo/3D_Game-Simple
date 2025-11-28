extends Node

signal coins_count_changed(new_count)

var coin_count:= 0

func add_coin():
	coin_count += 1
	emit_signal("coins_count_changed", coin_count)

func reset_coins():
	coin_count = 0
	emit_signal("coins_count_changed", coin_count)
