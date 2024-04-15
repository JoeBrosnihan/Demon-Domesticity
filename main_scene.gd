extends Node2D

var wait_before_start = 5 # How logn to wait before starting the game
var wait_before_summon = 5 # How long to wait before summon occurs

var fridge_label = null
var stove_label = null
var fridge = null
var stove = null

func _ready():
	fridge_label = find_child("FridgeLabel")
	fridge = get_node("Entities/Fridge")
	
	stove_label = find_child("StoveLabel")
	stove = get_node("Entities/Stove")
	
	await get_tree().create_timer(wait_before_start).timeout
	fridge_label.visible = true
	fridge.enable_interaction()

func _on_fridge_interacted():
	fridge_label.visible = false
	stove_label.visible = true
	stove.enable_interaction()

func _on_stove_interacted():
	stove_label.visible = false
	stove.find_child("EggSizzle").playing = true
	await get_tree().create_timer(wait_before_summon).timeout
	# START THE GAME BATTLE!!!
	get_tree().change_scene_to_file("res://dungeon.tscn")
