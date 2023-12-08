extends HBoxContainer

@onready var HeartGuiClass = preload("res://heart_gui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func setMaxHearts(max: int):
	for i in range(max):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)
		
func updateHearts(currentHealth_times4: int):
	var hearts = get_children()
	for i in range(currentHealth_times4 / 4):
		hearts[i].update(0)
	if currentHealth_times4 / 4 == hearts.size():
		return
	for i in range(currentHealth_times4 / 4, currentHealth_times4 / 4 + 1):
		hearts[i].update(4 - currentHealth_times4 % 4)
	for i in range(currentHealth_times4 / 4 + 1, hearts.size()):
		hearts[i].update(4)
