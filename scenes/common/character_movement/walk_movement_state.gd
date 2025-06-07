class_name WalkMovementState extends MovementState

func enter_state(_previous_state: State) -> void:
	pass

func exit_state(_next_state: State) -> void:
	pass

func get_next_state() -> State:
	return super.get_next_state()

func handle_physics_process(delta: float) -> void:
	character.default_physics_process(delta)
