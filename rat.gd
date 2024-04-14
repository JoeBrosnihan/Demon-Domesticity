extends RigidBody2D

# Reference to the player
var player = null

func _ready():
	print("getting player")
	# Assuming the player node is named "Player" and is at the root of your scene
	player = get_node("/root/Game/Entities/Player")
	print("player:", player)

func _integrate_forces(state):
	if player:
		var direction = (player.global_position - global_position).normalized()
		var force = direction * 10
		apply_central_impulse(force)

	if linear_velocity.x != 0:
		find_child("Visual").scale.x = sign(linear_velocity.x)
