extends Panel

@onready var sprite = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update(whole: int):
	if whole == 0: sprite.frame = 0
	elif whole == 1: sprite.frame = 1
	elif whole == 2: sprite.frame = 2
	elif whole == 3: sprite.frame = 3
	elif whole == 4: sprite.frame = 4
