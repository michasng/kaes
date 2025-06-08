class_name EnemyBrain extends CharacterBrain

func get_movement_axis() -> float:
	return 0.0

func wants_to_jump() -> bool:
	return false

func wants_to_use() -> bool:
	return false
