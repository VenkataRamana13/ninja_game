extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animations = $AnimatedSprite2D

var StartPosition 
var endPosition

func _ready():
	StartPosition = position 
	#if endPoint.size() > 0:
	endPosition = endPoint.global_position
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = StartPosition
	StartPosition = tempEnd
	
func updateAnimation():
	var animationString = "up"
	if velocity.y > 0: 
		animationString = "down"
	animations.play(animationString)
	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
		
	velocity = moveDirection.normalized() * speed
	
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)
	
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	handleCollision()
	updateAnimation()

func monster_killed():
	print("killed")
	queue_free()
