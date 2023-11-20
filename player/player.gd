extends CharacterBody2D

@export var speed: int = 35
@onready var animations = $AnimatedSprite2D

func handle_input():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed

func updateAnimation():
	if velocity.length() == 0:
		animations.stop()
	else: 
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
	
		animations.play("move" + direction)
	
	
func _physics_process(delta):
	handle_input()
	move_and_slide()
	updateAnimation()
