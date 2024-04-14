extends Node2D

var music = null
var timer = null

func _ready():
	music = find_child("Music")
	print(music)
	timer = get_node("/root/Dungeon/Entities/Timer")
	print(timer)
	get_node("/root/Dungeon/Entities/WizardEyes").dialog_completed.connect(self._start_battle)
	
func _start_battle():
	music.playing = true
	timer.start_timer()
