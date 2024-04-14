extends Node2D



func _on_summons_button_pressed():
	get_tree().change_scene_to_file("res://dungeon.tscn")
