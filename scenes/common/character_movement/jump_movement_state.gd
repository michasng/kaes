class_name JumpMovementState extends MovementState

func enter_state(_previous_state: State) -> void:
	character.velocity.y = -character.jump_velocity_pixels_per_second

func exit_state(_next_state: State) -> void:
	pass

func get_next_state() -> State:
	if character.is_on_floor():
		return get_next_floor_state()
	
	if character.velocity.y > 0:
		return fall_state
	return self

func handle_physics_process(delta: float) -> void:
	character.default_physics_process(delta)
