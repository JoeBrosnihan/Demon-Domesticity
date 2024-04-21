extends CharacterBody2D

# Speed at which the character moves.
var speed: float = 150.0
# Attack cooldown is stored on timer node
var attacking = false
var attack_pressed = false

signal attack_initiated

func _physics_process(delta):
	var motion = Vector2.ZERO
	
	# Check for input and adjust the motion vector accordingly.
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
	if Input.is_action_pressed("ui_down"):
		motion.y += 1
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
	
	if Input.is_action_pressed("attack"):
		if !attacking and !attack_pressed:
			attacking = true
			attack_pressed = true
			attack_initiated.emit()
			find_child("AttackCooldown").start()
	else:
		attack_pressed = false
		
	var anim = "stand" if motion == Vector2.ZERO else "walk"
	
	if attacking:
		anim = "attack"
		
	# Normalize the motion vector to ensure consistent movement speed in all directions.
	motion = motion.normalized() * speed
	
	find_child("Visual").find_child("AnimatedSprite2D").play(anim)
	
	if motion.x != 0:
		find_child("Visual").scale.x = sign(motion.x)

	# Update velocity
	velocity = motion  # Directly set velocity to motion vector
	move_and_slide()


func _on_attack_cooldown_timeout():
	attacking = false
