extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect to the attack_initiated signal emitted by the CharacterBody2D
	get_parent().attack_initiated.connect(self._on_attack_initiated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_attack_initiated():
	for body in get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(10)  # Example: Deal 10 damage to the entity
