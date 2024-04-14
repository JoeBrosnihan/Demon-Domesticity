extends RigidBody2D

var original_color = Color(0, 0, 0)
var damage_color = Color(15, 0, 0, 1)
var death_color = Color(0, 0, 0, 0)
var damage_duration = 0.5

var health = 30

# Reference to the player
var player = null
var sprite = null
var taking_damage = false

func _ready():
	print("getting player")
	# Assuming the player node is named "Player" and is at the root of your scene
	player = get_node("/root/Dungeon/Entities/Player")
	print("player:", player)
	sprite = find_child("Visual")
	original_color = sprite.modulate

func _integrate_forces(state):
	if player:
		var direction = (player.global_position - global_position).normalized()
		# Run away from player if taking damage
		var force_modifier = 1 if not taking_damage else -1
		var force = direction * 10 * force_modifier
		apply_central_impulse(force)
			

	if linear_velocity.x != 0:
		find_child("Visual").scale.x = sign(linear_velocity.x)
		
func die():
	find_child("CollisionShape2D").disabled = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", death_color, 0.5)
	await get_tree().create_timer(1).timeout
	self.queue_free()

@rpc("call_local")
func take_damage(amount: int):
	if taking_damage:
		print("alredy damaged")
		return
	
	taking_damage = true
	print("Rat took " + str(amount) + " damage" + str(taking_damage))
	
	health = health - amount
	if (health <= 0):
		self.die()
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", damage_color, 0.1)
	tween.tween_property(self, "modulate", original_color, 0.1)
	await get_tree().create_timer(damage_duration).timeout
	taking_damage = false
