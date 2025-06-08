class_name PlayerBrain extends CharacterBrain

func get_movement_axis() -> float:
	return Input.get_axis("left", "right")

func wants_to_jump() -> bool:
	return Input.is_action_pressed("jump")

func wants_to_use() -> bool:
	return Input.is_action_pressed("use")
