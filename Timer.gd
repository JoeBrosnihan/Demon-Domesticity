extends Node2D

var text = null
var timer = null

var time_limit_seconds = 30

signal timer_ended

func _ready():
	text = find_child("TimerText")
	timer = find_child("Timer")
	text.text = str(time_limit_seconds)
	timer.timeout.connect(self._on_timer_timeout)
	
	
@rpc("call_local")
func start_timer():
	self.visible = true
	timer.start()

func _on_timer_timeout():
	if time_limit_seconds > 0:
		time_limit_seconds = time_limit_seconds - 1
		text.text = str(time_limit_seconds)
		if time_limit_seconds == 0:
			timer_ended.emit()
