class_name PowersUI extends HBoxContainer


const PowerHotbarIcon = preload("res://scenes/PowerHotbarIcon.tscn")

func _ready():
	Globals.KittenPickup.connect(AnyPickup)
	pass

func _process(delta: float) -> void:
	pass
	
func CreateIconSlot(kitten) -> void:
	var iconCount = self.get_child_count()
	#if Input.is_action_just_pressed("Jump"):
	var NewIcon = PowerHotbarIcon.instantiate() # Create a new Sprite2D.
	#NewIcon.abilityIcon = Coca.sprite_2d
	NewIcon.set_powerup_icon(kitten.cat_icon)
	if iconCount < 5:
		add_child(NewIcon)
	print(iconCount)
	
	
func AnyPickup(kitten) -> void:	
	CreateIconSlot(kitten)
