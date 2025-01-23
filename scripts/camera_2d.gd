extends Camera2D


@onready var player = $"../Player"
func _physics_process(delta: float) -> void:
	position = lerp(position, player.position, 10*delta)
