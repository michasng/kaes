class_name State extends Node # abstract class

func enter_state(_previous_state: State) -> void:
	pass

func exit_state(_next_state: State) -> void:
	pass

func get_next_state() -> State:
	return self

func handle_physics_process(_delta: float) -> void:
	pass
