class_name powerHotbarIcon
extends AspectRatioContainer
@export var abilityIcon: TextureRect 

func _ready() -> void:
	pass # Replace with function body.

func set_powerup_icon(t):
	if not is_node_ready(): await is_node_ready()
	abilityIcon.texture = t

func _process(delta: float) -> void:
	pass
