extends StaticBody2D

var interactable = false
signal interacted

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


@rpc("call_local")
func enable_interaction():
	interactable = true

@rpc("call_local")
func take_damage(delta):
	if interactable:
		print("Kitchen appliance interacted")
		interactable = false
		interacted.emit()
