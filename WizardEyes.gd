extends CharacterBody2D

var wait_start = 1 # how long before dialog starts
var dialog_duration = 3 # how long dialog sticks up

var text = null

signal dialog_completed

func _ready():
	await get_tree().create_timer(wait_start).timeout
	text = find_child("RichTextLabel")
	text.visible = true
	find_child("Audio").playing = true
	await get_tree().create_timer(dialog_duration).timeout
	text.visible = false
	
	dialog_completed.emit()
