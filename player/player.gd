extends CharacterBody2D

signal healthChanged

@export var speed: int = 55
@onready var animations = $AnimatedSprite2D
@onready var hurtColor = $Sprite2D/ColorRect
@onready var effects = $Effects
@onready var hurtTimer = $hurtTimer

@export var maxHealth = 12
@export var knockbackPower: int = 500
@onready var currentHealth: int = maxHealth

var lastAnimDirection: String = "Down"
var isAttacking: bool = false


func _ready():
	effects.play("RESET")

func handle_input():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	

func updateAnimation():
	if isAttacking: return 
	if velocity.length() == 0:
		animations.stop()
	else: 
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
	
		animations.play("move" + direction)
		lastAnimDirection = direction
	
	
func _physics_process(delta):
	handle_input()
	move_and_slide()
	updateAnimation()


func _on_hurtbox_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().velocity)
		effects.play("hurtBlink")
		hurtTimer.start()
		await hurtTimer.timeout
		effects.play("RESET")
	if area.name == "villagerConvoBox":
		DialogueManager.show_example_dialogue_balloon(load("res://dialouges/main.dialogue"), "villager")
	if area.name == "housedoor":
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://house.tscn")

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()

# Declare the property
var _house : Node = null

# Define the setter
func set_house(new_house: Node) -> void:
	if new_house != null:
		$Prompt.play("KeyPrompt")
		$KeyPrompt.show()
	else:
		$Prompt.stop()
		$KeyPrompt.hide()

	_house = new_house

# Define the getter
func get_house() -> Node:
	return _house
