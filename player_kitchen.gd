extends CharacterBody2D

# Speed at which the character moves.
var speed: float = 150.0

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
		attack_initiated.emit()

	# Normalize the motion vector to ensure consistent movement speed in all directions.
	motion = motion.normalized() * speed
	
	var anim = "stand" if motion == Vector2.ZERO else "walk"
	find_child("Visual").find_child("AnimatedSprite2D").play(anim)
	
	if motion.x != 0:
		find_child("Visual").scale.x = sign(motion.x)

	# Update velocity
	velocity = motion  # Directly set velocity to motion vector
	move_and_slide()
