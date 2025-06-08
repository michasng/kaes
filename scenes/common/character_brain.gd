class_name CharacterBrain extends Node # abstract class

func get_movement_axis() -> float:
	return 0.0

func wants_to_move_left() -> bool:
	return get_movement_axis() < 0

func wants_to_move_right() -> bool:
	return get_movement_axis() > 0

func wants_to_jump() -> bool:
	return false

func wants_to_use() -> bool:
	return false
